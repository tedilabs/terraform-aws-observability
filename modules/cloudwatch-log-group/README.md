# cloudwatch-log-group

This module creates following resources.

- `aws_cloudwatch_log_group`
- `aws_cloudwatch_log_stream` (optional)
- `aws_cloudwatch_log_metric_filter` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.60 |

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
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_metric_filter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_log_stream.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the CloudWatch log group. | `string` | n/a | yes |
| <a name="input_encryption_kms_key"></a> [encryption\_kms\_key](#input\_encryption\_kms\_key) | (Optional) The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested. | `string` | `null` | no |
| <a name="input_metric_filters"></a> [metric\_filters](#input\_metric\_filters) | (Required) A list of metric filters for CloudWatch log group. Log events that match the pattern you define are recorded to the metric that you specify. You can graph the metric and set alarms to notify you. Each item of `metric_filters` as defined below.<br>    (Required) `name` - A name for the metric filter.<br>    (Optional) `pattern` - A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events. Filter patterns are case sensitive. Defaults to `" "` (match everything in your log events).<br>    (Required) `metric` - A configuration to define how metric data gets emitted. `metric` as defined below.<br>      (Required) `namespace` - The destination namespace of the CloudWatch metric. Namespace let you group similar metrics. Can be up to 255 characters long; all characters are valid except for colon(:), asterisk(*), dollar($), and space( ).<br>      (Required) `name` - The name of the CloudWatch metric to which the monitored log information should be published. Must be unique within the namespace.<br>      (Required) `value` - What to publish to the metric. For example, if you're counting the occurrences of a particular term like "Error", the value will be `1` for each occurrence. Alternatively, enter a token, such as `$size`. This increments the metric by the value of the number in the size field for every log event that contains a size field.<br>      (Optional) `default_value` - The value to emit when a filter pattern does not match a log event. Conflicts with `dimensions`.<br>      (Optional) `dimensions` - A map of fields to use as dimensions for the metric. Up to 3 dimensions are allowed. Conflicts with `default_value`.<br>      (Optional) `unit` - The unit to assign to the metric. Defaults to `None`. | <pre>list(object({<br>    name    = string<br>    pattern = optional(string, "\" \"")<br>    metric = object({<br>      namespace     = string<br>      name          = string<br>      value         = string<br>      default_value = optional(string)<br>      dimensions    = optional(map(string))<br>      unit          = optional(string, "None")<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_module_tags_enabled"></a> [module\_tags\_enabled](#input\_module\_tags\_enabled) | (Optional) Whether to create AWS Resource Tags for the module informations. | `bool` | `true` | no |
| <a name="input_resource_group_description"></a> [resource\_group\_description](#input\_resource\_group\_description) | (Optional) The description of Resource Group. | `string` | `"Managed by Terraform."` | no |
| <a name="input_resource_group_enabled"></a> [resource\_group\_enabled](#input\_resource\_group\_enabled) | (Optional) Whether to create Resource Group to find and group AWS resources which are created by this module. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. | `string` | `""` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | (Optional) Specify the number of days to retain log events in the log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, and 0. If you select 0, the events in the log group are always retained and never expire. Default to `90` days. | `number` | `90` | no |
| <a name="input_skip_destroy"></a> [skip\_destroy](#input\_skip\_destroy) | (Optional) Set to true if you do not wish the log group to be deleted at destroy time, and instead just remove the log group from the Terraform state. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_streams"></a> [streams](#input\_streams) | (Optional) A list of log streams for the CloudWatch log group. | `set(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the CloudWatch log group. |
| <a name="output_encryption_kms_key"></a> [encryption\_kms\_key](#output\_encryption\_kms\_key) | The ARN of the KMS Key for log data encryption. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the CloudWatch log group. |
| <a name="output_metric_filters"></a> [metric\_filters](#output\_metric\_filters) | The list of metric filters for the log group. |
| <a name="output_name"></a> [name](#output\_name) | The name of CloudWatch log group. |
| <a name="output_retention_in_days"></a> [retention\_in\_days](#output\_retention\_in\_days) | The number of days to retain log events in the log group. |
| <a name="output_streams"></a> [streams](#output\_streams) | The list of log streams for the log group. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
