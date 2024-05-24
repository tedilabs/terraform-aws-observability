# cloudwatch-oam-link
This module creates following resources.

- `aws_oam_link`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.51.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | tedilabs/misc/aws//modules/resource-group | ~> 0.10.0 |

## Resources

| Name | Type |
|------|------|
| [aws_oam_link.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/oam_link) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the CloudWatch OAM link. | `string` | n/a | yes |
| <a name="input_sink"></a> [sink](#input\_sink) | (Required) The ARN of the sink to use to create this link. | `string` | n/a | yes |
| <a name="input_account_label"></a> [account\_label](#input\_account\_label) | (Optional) A label to help identify your source account. In the monitoring account, the account label is displayed with data from that source account. The account label is displayed in charts and search experiences to help you identify account context. Support use following template variables. Defaults to `$AccountName`.<br>  - `$AccountName`: Account name used to identify accounts.<br>  - `$AccountEmail`: Email address used to identify accounts. (i.e. name@amazon.com)<br>  - `$AccountEmailNoDomain`: Email address without domain (i.e. without @amazon.com) used to identify accounts. | `string` | `"$AccountName"` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_telemetry_types"></a> [telemetry\_types](#input\_telemetry\_types) | (Optional) A set of the telemetry types that the source account shares with the monitoring account. Valid values are `AWS::CloudWatch::Metric`, `AWS::Logs::LogGroup`, `AWS::XRay::Trace`, `AWS::ApplicationInsights::Application`, `AWS::InternetMonitor::Monitor`. | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_label"></a> [account\_label](#output\_account\_label) | A label to help identify your source account. |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the CloudWatch OAM link. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the CloudWatch OAM link. |
| <a name="output_name"></a> [name](#output\_name) | The name of CloudWatch OAM link. |
| <a name="output_sink"></a> [sink](#output\_sink) | The information of the sink for this link. |
| <a name="output_telemetry_types"></a> [telemetry\_types](#output\_telemetry\_types) | A set of the telemetry types that the source account shares with the monitoring account. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
