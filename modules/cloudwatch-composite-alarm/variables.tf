variable "name" {
  description = "(Required) The name for the CloudWatch composite alarm. This name must be unique within the region."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) The description for the CloudWatch composite alarm."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "rule" {
  description = <<EOF
  (Required) An expression that specifies which other alarms are to be evaluated to determine this composite alarm's state. For each alarm that you reference, you designate a function that specifies whether that alarm needs to be in `ALARM` state, `OK` state, or `INSUFFICIENT_DATA` state. You can use operators (`AND`, `OR` and `NOT`) to combine multiple functions in a single expression. You can use parenthesis to logically group the functions in your expression. You can use either alarm names or ARNs to reference the other alarms that are to be evaluated.

  Functions can include the following:

  - `ALARM("`alarm-name` or `alarm-arn`")` : `true` if the named alarm is in `ALARM` state.
  - `OK("`alarm-name` or `alarm-arn` ")` : `true` if the named alarm is in `OK` state.
  - `INSUFFICIENT_DATA("`alarm-name` or `alarm-arn` ")` `true` if the named alarm is in `INSUFFICIENT_DATA` state.
  - `TRUE` always evaluates to `true`.
  - `FALSE` always evaluates to `true`.

  Alarm names specified in AlarmRule can be surrounded with double-quotes ("), but do not have to be. `TRUE` and `FALSE` are useful for testing a complex `rule` structure, and for testing your alarm actions.

  The rule can specify as many as 100 children alarms. The rule expression can have as many as 500 elements. Elements are child alarms, TRUE or FALSE statements, and parentheses.
  EOF
  type        = string
  nullable    = false
}

variable "actions_enabled" {
  description = "(Optional) Indicate whether actions should be executed during any changes to the alarm state of the composite alarm. Defaults to `true`."
  type        = bool
  default     = true
  nullable    = false
}

variable "actions_on_ok" {
  description = "(Optional) The set of actions to execute when this alarm transitions to an `OK` state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "actions_on_alarm" {
  description = "(Optional) The set of actions to execute when this alarm transitions to the `ALARM` state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "actions_on_insufficient_data" {
  description = "(Optional) The set of actions to execute when this alarm transitions to the `INSUFFICIENT_DATA` state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed."
  type        = set(string)
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
