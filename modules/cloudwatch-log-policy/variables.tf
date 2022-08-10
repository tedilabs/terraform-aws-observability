variable "name" {
  description = "(Required) The name of the CloudWatch Logs resource policy."
  type        = string
}

variable "service" {
  description = "(Required) Specify the identity of the AWS service principal to allow delivering logs to this account. Valid values are `es.amazonaws.com`, `route53.amazonaws.com`."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["es.amazonaws.com", "route53.amazonaws.com"], var.service)
    error_message = "Valid values for `service` are `es.amazonaws.com`, `route53.amazonaws.com`."
  }
}

variable "statements" {
  description = <<EOF
  (Required) A list of statements for CloudWatch Logs resource policy. Each item of `statements` as defined below.
    (Required) `log_groups` - A list of Log group patterns that the resource policy applies to. Whildcard is supported. Configure `*` to allow all log groups.
    (Optional) `account_whiteilst` - A whitelist of AWS Account IDs making the call to CloudWatch Logs.
    (Optional) `resource_whiteilst` - A whitelist of the ARN of AWS resources making the call to CloudWatch Logs.
  EOF
  type        = list(map(set(string)))
  default     = []
  nullable    = false
}
