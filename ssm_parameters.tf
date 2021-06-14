resource "aws_ssm_parameter" "domain_fsx_username" {
  name        = "/${local.workspace.name}/fsx_username"
  description = "FSx Domain username"
  type        = "String"
  value       = local.workspace.domain_fsx_username
  overwrite   = true
}

resource "aws_ssm_parameter" "domain_fsx_password" {
  name        = "/${local.workspace.name}/fsx_password"
  description = "FSx Domain password"
  type        = "SecureString"
  overwrite   = true
  value       = local.workspace.domain_fsx_password
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "domain_name" {
  name        = "/${local.workspace.name}/domain_name"
  description = "Domain name"
  type        = "String"
  value       = local.ad_directory.name
  overwrite   = true
}

resource "aws_ssm_parameter" "domain_ou_path" {
  name        = "/${local.workspace.name}/domain_ou_path"
  description = "Domain OU path"
  type        = "String"
  value       = local.workspace.domain_ou_path
  overwrite   = true
}

resource "aws_ssm_parameter" "ipdns" {
  name        = "/${local.workspace.name}/domain_dns_ip"
  description = "DNS IP Address"
  type        = "String"
  value       = join(",", [local.ad_directory.ip1, local.ad_directory.ip2]) # need added second ip
  overwrite   = true
}