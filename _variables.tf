

variable "ad_directory_name" {
  type    = string
  default = "example.com"
}

variable "ad_directory_ip1" {
  type    = string
  default = "XXX.XXX.XXX.XXX"
}

variable "ad_directory_ip2" {
  type    = string
  default = "XXX.XXX.XXX.XXX"
}

variable "fsx_name" {
  type    = string
  default = "fsxblogpost"
}

variable "domain_ou_path" {
  type    = string
  default = "OU=Domain Controllers,DC=example,DC=com"
}

variable "domain_fsx_username" {
  type    = string
  default = "fsx"
}

variable "domain_fsx_password" {
  type    = string
  default = "placeholder"
}

variable "fsx_deployment_type" {
  type    = string
  default = "SINGLE_AZ_1"
}

variable "fsx_subnet_ids" {
  type    = list(string)
  default = ["subnet-XXXXXXXXXXXX"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-XXXXXXXXXXXX"
}


