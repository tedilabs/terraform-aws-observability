# cloudwatch-log-policy

This module creates following resources.

- `aws_cloudwatch_log_policy`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_resource_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the CloudWatch Logs resource policy. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | (Required) Specify the identity of the AWS service principal to allow delivering logs to this account. Valid values are `delivery.logs.amazonaws.com`, `es.amazonaws.com`, `events.amazonaws.com`, `route53.amazonaws.com`. | `string` | n/a | yes |
| <a name="input_statements"></a> [statements](#input\_statements) | (Required) A list of statements for CloudWatch Logs resource policy. Each item of `statements` as defined below.<br>    (Required) `log_groups` - A list of Log group patterns that the resource policy applies to. Whildcard is supported. Configure `*` to allow all log groups.<br>    (Optional) `account_whiteilst` - A whitelist of AWS Account IDs making the call to CloudWatch Logs.<br>    (Optional) `resource_whiteilst` - A whitelist of the ARN of AWS resources making the call to CloudWatch Logs. | `list(map(set(string)))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | The name of CloudWatch Logs resource policy. |
| <a name="output_service"></a> [service](#output\_service) | The identity of the AWS service principal which is allowed to delivery logs to this account. |
| <a name="output_statements"></a> [statements](#output\_statements) | The list of statements for CloudWatch Logs resource policy. |
<!-- END_TF_DOCS -->
