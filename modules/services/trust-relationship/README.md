# AWS Trust Relationship Module

This module will deploy a Trust Relationship (IAM Role) into a single AWS account, or each account within an AWS Organization.

The following resources will be created in each instrumented account:
- An IAM Role and associated IAM Policiy (`arn:aws:iam::aws:policy/SecurityAudit`) to grant Sysdig read only permissions to secure you AWS Account.
    - An Access Policy attached to this role using a Sysdig provided `ExternalId`. 

If instrumenting an AWS Organization, an `aws_cloudformation_stack_set` will be created in the Management Account. 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.62.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.62.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack_set.stackset](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set) | resource |
| [aws_cloudformation_stack_set_instance.stackset_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance) | resource |
| [aws_iam_role.cspm_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | Random string generated unique to a customer | `string` | n/a | yes |
| <a name="input_trusted_identity"></a> [trusted\_identity](#input\_trusted\_identity) | The name of sysdig trusted identity | `string` | n/a | yes |
| <a name="input_is_organizational"></a> [is\_organizational](#input\_is\_organizational) | true/false whether secure-for-cloud should be deployed in an organizational setup (all accounts of org) or not (only on default aws provider account) | `bool` | `false` | no |
| <a name="input_org_units"></a> [org\_units](#input\_org\_units) | Org unit id to install cspm | `set(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | Default region for resource creation in organization mode | `string` | `"eu-central-1"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of the IAM Role that will be created. | `string` | `"sysdig-secure"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | sysdig secure-for-cloud tags. always include 'product' default tag for resource-group proper functioning | `map(string)` | <pre>{<br>  "product": "sysdig-secure-for-cloud"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.
