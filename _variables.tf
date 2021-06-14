locals {

  ad_directory = {
    name = "example.com"
    ip1  = "XXX.XXX.XXX.XXX"
    ip2  = "XXX.XXX.XXX.XXX"
  }

  env = {
    default = {
      name                = "fsxblogpost"
      domain_ou_path      = "OU=Domain Controllers,DC=example,DC=com"
      domain_fsx_username = "fsx"
      domain_fsx_password = "placeholder"
      fsx_deployment_type = "SINGLE_AZ_1"
      fsx_subnet_ids      = ["subnet-XXXXXXXXXXXX"]
      vpc_id              = "vpc-XXXXXXXXXXXX"
    }
  }

  workspace = local.env[terraform.workspace]
}