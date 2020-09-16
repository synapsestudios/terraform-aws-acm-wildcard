# AWS ACM Wildcard

This module generates AWS ACM SSL Certificates for a given Route53 DNS Zone in regions us-west-2 & us-east-1. 

*It should be noted that this module uses an anti-pattern as it includes providers for AWS in two regions. Removing these resources if needed is currently a manual process. Once resources are removed you should also manually remove them from your terraform state.*

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.29 |
| aws | ~> 2.53 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.53 |
| aws.us-east-1 | ~> 2.53 |
| aws.us-west-2 | ~> 2.53 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_assume\_role\_arn | ARN of the AWS role to assume when running this deployment. | `string` | n/a | yes |
| dns\_zone | Name of the DNS zone to use with this deployment. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| us\_east\_1\_acm\_certificate\_arn | n/a |
| us\_west\_2\_acm\_certificate\_arn | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->