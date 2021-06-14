data "aws_iam_policy_document" "fsx_kms" {
  statement {
    sid       = "Allow FSx to encrypt storage"
    actions   = ["kms:GenerateDataKey"]
    resources = ["*"]
    principals {
      type        = "Service"
      identifiers = ["fsx.amazonaws.com"]
    }
  }
  statement {
    sid       = "Allow account to manage key"
    actions   = ["kms:*"]
    resources = ["arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_kms_key" "fsx" {
  description             = "FSx Key"
  deletion_window_in_days = 7
  policy                  = data.aws_iam_policy_document.fsx_kms.json
}

resource "aws_fsx_windows_file_system" "fsx" {
  kms_key_id          = aws_kms_key.fsx.arn
  storage_capacity    = 100
  subnet_ids          = local.workspace.fsx_subnet_ids
  throughput_capacity = 32
  security_group_ids  = [aws_security_group.fsx_sg.id]
  deployment_type     = local.workspace.fsx_deployment_type
  #preferred_subnet_id = local.workspace.fsx_subnet_ids

  self_managed_active_directory {
    dns_ips                                = split(",", aws_ssm_parameter.ipdns.value)
    domain_name                            = aws_ssm_parameter.domain_name.value
    password                               = aws_ssm_parameter.domain_fsx_password.value
    username                               = aws_ssm_parameter.domain_fsx_username.value
    organizational_unit_distinguished_name = aws_ssm_parameter.domain_ou_path.value
  }
}

resource "aws_security_group" "fsx_sg" {
  name        = "${local.workspace.name}-fsx" #var.name
  description = "SG for FSx"
  vpc_id      = data.aws_vpc.selected.id

  tags = {
    Name = "-${local.workspace.name}-fsx"
  }
}

resource "aws_security_group_rule" "fsx_default_egress" {
  description       = "Traffic to internet"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.fsx_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "fsx_access_from_vpc" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.fsx_sg.id
  cidr_blocks       = [data.aws_vpc.selected.cidr_block]
}
