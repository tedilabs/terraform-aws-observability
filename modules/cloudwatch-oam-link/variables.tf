variable "name" {
  description = "(Required) The name of the CloudWatch OAM link."
  type        = string
  nullable    = false
}

variable "sink" {
  description = "(Required) The ARN of the sink to use to create this link."
  type        = string
  nullable    = false
}

variable "account_label" {
  description = <<EOF
  (Optional) A label to help identify your source account. In the monitoring account, the account label is displayed with data from that source account. The account label is displayed in charts and search experiences to help you identify account context. Support use following template variables. Defaults to `$AccountName`.
  - `$AccountName`: Account name used to identify accounts.
  - `$AccountEmail`: Email address used to identify accounts. (i.e. name@amazon.com)
  - `$AccountEmailNoDomain`: Email address without domain (i.e. without @amazon.com) used to identify accounts.
  EOF
  type        = string
  default     = "$AccountName"
  nullable    = false
}

variable "telemetry_types" {
  description = "(Optional) A set of the telemetry types that the source account shares with the monitoring account. Valid values are `AWS::CloudWatch::Metric`, `AWS::Logs::LogGroup`, `AWS::XRay::Trace`, `AWS::ApplicationInsights::Application`, `AWS::InternetMonitor::Monitor`."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition = alltrue([
      for telemetry_type in var.telemetry_types :
      contains(["AWS::CloudWatch::Metric", "AWS::Logs::LogGroup", "AWS::XRay::Trace", "AWS::ApplicationInsights::Application", "AWS::InternetMonitor::Monitor"], telemetry_type)
    ])
    error_message = "Valid values for `telemetry_types` are `AWS::CloudWatch::Metric`, `AWS::Logs::LogGroup`, `AWS::XRay::Trace`, `AWS::ApplicationInsights::Application`, `AWS::InternetMonitor::Monitor`."
  }
}

variable "log_group_configuration" {
  description = <<EOF
  (Optional) A configuration for filtering which log groups are to send log events from the source account to the monitoring account. `log_group_configuration` as defined below.
    (Optional) `filter` - Filter string that specifies which log groups are to share their log events with the monitoring account.
  EOF
  type = object({
    filter = optional(string, "")
  })
  default  = {}
  nullable = false
}

variable "metric_configuration" {
  description = <<EOF
  (Optional) A configuration for filtering which metric namespaces are to be shared from the source account to the monitoring account. `log_group_configuration` as defined below.
    (Optional) `filter` - Filter string that specifies which metrics are to be shared with the monitoring account.
  EOF
  type = object({
    filter = optional(string, "")
  })
  default  = {}
  nullable = false
}

variable "tags" {
  description = "(Optional) A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "(Optional) Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################




variable "resource_group" {
  description = <<EOF
  (Optional) A configurations of Resource Group for this module. `resource_group` as defined below.
    (Optional) `enabled` - Whether to create Resource Group to find and group AWS resources which are created by this module. Defaults to `true`.
    (Optional) `name` - The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`. If not provided, a name will be generated using the module name and instance name.
    (Optional) `description` - The description of Resource Group. Defaults to `Managed by Terraform.`.
  EOF
  type = object({
    enabled     = optional(bool, true)
    name        = optional(string, "")
    description = optional(string, "Managed by Terraform.")
  })
  default  = {}
  nullable = false
}
