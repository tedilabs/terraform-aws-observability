variable "name" {
  description = "(Required) The name of the CloudWatch OAM sink."
  type        = string
  nullable    = false
}

variable "telemetry_types" {
  description = "(Optional) A set of the telemetry types can be shared with it. Valid values are `AWS::CloudWatch::Metric`, `AWS::Logs::LogGroup`, `AWS::XRay::Trace`, `AWS::ApplicationInsights::Application`, `AWS::InternetMonitor::Monitor`."
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

variable "allowed_source_accounts" {
  description = "(Optional) A list of the IDs of AWS accounts that will share data with this monitoring account."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "allowed_source_organizations" {
  description = "(Optional) A list of the organization IDs of AWS accounts that will share data with this monitoring account."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "allowed_source_organization_paths" {
  description = "(Optional) A list of the organization paths of the AWS accounts that will share data with this monitoring account."
  type        = list(string)
  default     = []
  nullable    = false
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

variable "resource_group_enabled" {
  description = "(Optional) Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "(Optional) The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "(Optional) The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
