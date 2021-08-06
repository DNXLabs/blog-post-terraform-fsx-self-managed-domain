# blog-post-terraform-fsx-self-managed-domain

[![Lint Status](https://github.com/DNXLabs/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-template)](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE)

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ad\_directory\_ip1 | n/a | `string` | `"XXX.XXX.XXX.XXX"` | no |
| ad\_directory\_ip2 | n/a | `string` | `"XXX.XXX.XXX.XXX"` | no |
| ad\_directory\_name | n/a | `string` | `"example.com"` | no |
| domain\_fsx\_password | n/a | `string` | `"placeholder"` | no |
| domain\_fsx\_username | n/a | `string` | `"fsx"` | no |
| domain\_ou\_path | n/a | `string` | `"OU=Domain Controllers,DC=example,DC=com"` | no |
| fsx\_deployment\_type | n/a | `string` | `"SINGLE_AZ_1"` | no |
| fsx\_name | n/a | `string` | `"fsxblogpost"` | no |
| fsx\_subnet\_ids | n/a | `list(string)` | <pre>[<br>  "subnet-XXXXXXXXXXXX"<br>]</pre> | no |
| vpc\_id | n/a | `string` | `"vpc-XXXXXXXXXXXX"` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE) for full details.