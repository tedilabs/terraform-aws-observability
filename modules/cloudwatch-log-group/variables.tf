variable "name" {
  description = "(Required) The name of the CloudWatch log group."
  type        = string
  nullable    = false
}

variable "skip_destroy" {
  description = "(Optional) Set to true if you do not wish the log group to be deleted at destroy time, and instead just remove the log group from the Terraform state. Defaults to `false`."
  type        = bool
  default     = false
  nullable    = false
}

variable "retention_in_days" {
  description = "(Optional) Specify the number of days to retain log events in the log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, and 0. If you select 0, the events in the log group are always retained and never expire. Default to `90` days."
  type        = number
  default     = 90
  nullable    = false
}

variable "encryption_kms_key" {
  description = "(Optional) The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
  type        = string
  default     = null
}

variable "streams" {
  description = "(Optional) A list of log streams for the CloudWatch log group."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "metric_filters" {
  description = <<EOF
  (Required) A list of metric filters for CloudWatch log group. Log events that match the pattern you define are recorded to the metric that you specify. You can graph the metric and set alarms to notify you. Each item of `metric_filters` as defined below.
    (Required) `name` - A name for the metric filter.
    (Optional) `pattern` - A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events.
    (Required) `metric` - A configuration to define how metric data gets emitted. `metric` as defined below.
      (Required) `namespace` - The destination namespace of the CloudWatch metric. Namespace let you group similar metrics. Can be up to 255 characters long; all characters are valid except for colon(:), asterisk(*), dollar($), and space( ).
      (Required) `name` - The name of the CloudWatch metric to which the monitored log information should be published. Must be unique within the namespace.
      (Required) `value` - What to publish to the metric. For example, if you're counting the occurrences of a particular term like "Error", the value will be "1" for each occurrence. If you're counting the bytes transferred the published value will be the value in the log event.
      (Optional) `default_value` - The value to emit when a filter pattern does not match a log event. Conflicts with `dimensions`.
      (Optional) `dimensions` - A map of fields to use as dimensions for the metric. Up to 3 dimensions are allowed. Conflicts with `default_value`.
      (Optional) `unit` - The unit to assign to the metric. Defaults to `None`.
  EOF
  type = list(object({
    name    = string
    pattern = optional(string, "")
    metric = object({
      namespace     = string
      name          = string
      value         = string
      default_value = optional(string)
      dimensions    = optional(map(string))
      unit          = optional(string, "None")
    })
  }))
  default  = []
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
