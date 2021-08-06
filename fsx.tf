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
  subnet_ids          = var.fsx_subnet_ids
  throughput_capacity = 32
  security_group_ids  = [aws_security_group.fsx_sg.id]
  deployment_type     = var.fsx_deployment_type

  self_managed_active_directory {
    dns_ips                                = [var.ad_directory_ip1, var.ad_directory_ip2]
    domain_name                            = var.ad_directory_name
    username                               = var.domain_fsx_username
    password                               = var.domain_fsx_password
    organizational_unit_distinguished_name = var.domain_ou_path
  }
}

resource "aws_security_group" "fsx_sg" {
  name        = "${var.fsx_name}-fsx-sg"
  description = "SG for FSx"
  vpc_id      = data.aws_vpc.selected.id

  tags = {
    Name = "${var.fsx_name}-fsx-sg"
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
