# cloudwatch-oam-sink
This module creates following resources.

- `aws_oam_sink`
- `aws_oam_sink_policy` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.19.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_oam_sink.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/oam_sink) | resource |
| [aws_oam_sink_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/oam_sink_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the CloudWatch OAM sink. | `string` | n/a | yes |
| <a name="input_allowed_source_accounts"></a> [allowed\_source\_accounts](#input\_allowed\_source\_accounts) | (Optional) A list of the IDs of AWS accounts that will share data with this monitoring account. | `list(string)` | `[]` | no |
| <a name="input_allowed_source_organization_paths"></a> [allowed\_source\_organization\_paths](#input\_allowed\_source\_organization\_paths) | (Optional) A list of the organization paths of the AWS accounts that will share data with this monitoring account. | `list(string)` | `[]` | no |
| <a name="input_allowed_source_organizations"></a> [allowed\_source\_organizations](#input\_allowed\_source\_organizations) | (Optional) A list of the organization IDs of AWS accounts that will share data with this monitoring account. | `list(string)` | `[]` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_telemetry_types"></a> [telemetry\_types](#input\_telemetry\_types) | (Optional) A set of the telemetry types can be shared with it. Valid values are `AWS::CloudWatch::Metric`, `AWS::Logs::LogGroup`, `AWS::XRay::Trace`. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allowed_source_accounts"></a> [allowed\_source\_accounts](#output\_allowed\_source\_accounts) | A list of the IDs of AWS accounts allowed to share data with this monitoring account. |
| <a name="output_allowed_source_organization_paths"></a> [allowed\_source\_organization\_paths](#output\_allowed\_source\_organization\_paths) | A list of the organization paths of AWS accounts allowed to share data with this monitoring account. |
| <a name="output_allowed_source_organizations"></a> [allowed\_source\_organizations](#output\_allowed\_source\_organizations) | A list of the organization IDs of AWS accounts allowed to share data with this monitoring account. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the CloudWatch OAM sink. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the CloudWatch OAM sink. |
| <a name="output_name"></a> [name](#output\_name) | The name of CloudWatch OAM sink. |
| <a name="output_telemetry_types"></a> [telemetry\_types](#output\_telemetry\_types) | A set of the telemetry types can be shared with it. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
