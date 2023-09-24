variable "name" {
  description = "(Required) The name for the CloudWatch metric alarm. This name must be unique within the region."
  type        = string
  nullable    = false
}

variable "description" {
  description = "(Optional) The description for the CloudWatch metric alarm."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}

variable "metric" {
  description = <<EOF
  (Optional) An expression that specifies which other alarms are to be evaluated to determine this metric alarm's state. For each alarm that you reference, you designate a function that specifies whether that alarm needs to be in `ALARM` state, `OK` state, or `INSUFFICIENT_DATA` state. You can use operators (`AND`, `OR` and `NOT`) to combine multiple functions in a single expression. You can use parenthesis to logically group the functions in your expression. You can use either alarm names or ARNs to reference the other alarms that are to be evaluated. `metric` as defined below.
    (Required) `namespace` - The namespace for the metric associated with the alarm.
    (Required) `name` - The name for the metric associated with the alarm.
    (Optional) `dimensions` - The dimensions for the metric associated with the alarm. A dimension is a name/value pair that is part of the identity of a metric. Because dimensions are part of the unique identifier for a metric, whenever you add a unique name/value pair to one of your metrics, you are creating a new variation of that metric. For example, many Amazon EC2 metrics publish `InstanceId` as a dimension name, and the actual instance ID as the value for that dimension. You can assign up to 30 dimensions to a metric.

    (Required) `statistic` - The statistic for the metric associated with the alarm. Supported values are `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`.
    (Optional) `unit` - The unit of measure for the statistic. For example, the units for the Amazon EC2 `NetworkIn` metric are `Bytes` because `NetworkIn` tracks the number of bytes that an instance receives on all network interfaces. You can also specify a unit when you create a custom metric. Units help provide conceptual meaning to your data. Metric data points that specify a unit of measure, such as `Percent`, are aggregated separately. Recommend omitting `unit` so that you don't inadvertently specify an incorrect unit that is not published for this metric. Doing so causes the alarm to be stuck in the `INSUFFICIENT_DATA` state.
    (Required) `period` - The length, in seconds, used each time the metric is evaluated. Valid values are `10`, `30`, and any multiple of `60`. For metrics with regular resolution, valid values are any multiple of `60`. For high-resolution metrics, valid values are `10`, `30`, or any multiple of `60`. Specifying `10` or `30` also sets this alarm as a high-resolution alarm, which has a higher charge than other alarms. The result of `period` multiplied by `evaluation_periods` cannot be more than `86400` seconds.

  If you are creating an alarm based on a math expression, you cannot specify this parameter. Instead, you specify all this information in the `metric_query` parameter.
  EOF
  type = object({
    namespace  = string
    name       = string
    dimensions = optional(map(string), {})

    statistic = string
    unit      = optional(string)
    period    = number
  })
  default  = null
  nullable = true
}

variable "evaluation" {
  description = <<EOF
  (Optional) A configuration of the CloudWatch alarm state evaluation. `evaluation` as defined below.
    (Required) `operator` - The arithmetic operation to use when comparing the specified metric and threshold. The specified `statistic` value is used as the first operand. Either of the following is supported: `GreaterThanOrEqualToThreshold`, `GreaterThanThreshold`, `LessThanThreshold`, `LessThanOrEqualToThreshold`. Additionally, the values `LessThanLowerOrGreaterThanUpperThreshold`, `LessThanLowerThreshold`, and `GreaterThanUpperThreshold` are used only for alarms based on anomaly detection models.
    (Required) `threshold` - A configuration for the threshold to compare with the metric or expression. `threshold` as defined below.
      (Optional) `type` - A type of the threshold to choose how the threshold should be evaluated based on a static value or an anomaly detection band value. A static threshold evaluates the datapoint by using the threshold value that you configure. An anomaly deteciton band threshold analyzes past metric data and creates a model of expected values. Valid values are `STATIC` and `ANOMALY_DETECTION_BAND`. Defaults to `STATIC`.
      (Required) `value` - The value against which the specified statistic is compared. This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models.
    (Optional) `threshold_metric` - If this is an alarm based on an anomaly detection model, make this value match the ID of the ANOMALY_DETECTION_BAND function.
    (Optional) `period` - The number of datapoints over which data is compared to the specified threshold. If you are setting an alarm that requires that a number of consecutive data points be violating to trigger the alarm, this value specifies that number. If you are setting an "M out of N" alarm, this value is the N. Defaults to `1`.
    (Optional) `violation_limit` - The number of datapoints that must be violating to trigger the alarm. If you are setting an "M out of N" alarm, this value is the M. Defaults to `1`.
    (Optional) `missing_data_treatment` - Configure how this alarm is to handle missing data points. Valid values are `MISSING`, `IGNORE`, `VIOLATION`, `NO_VIOLATION`. Defaults to `MISSING`.

    - `MISSING`: Treat missing data as missing.
    - `IGNORE`: Treat missing data as ignore (maintain the alarm state).
    - `VIOLATION`: Treat missing data as bad (breaching threshold).
    - `NO_VIOLATION`: Treat missing data as good (not breaching threshold).

    Alarms that evaluate metrics in the `AWS/DynamoDB` namespace always ignore missing data even if you choose a different option.

    (Optional) `low_sample_percentile_treatment` -  Configure how to treat percentiles with low samples. Used only for alarms based on percentiles. Valid values are `EVALUATE`, `IGNORE`. Defaults to `EVALUATE`.

    - `EVALUATE`: The alarm is always evaluated and possibly changes state no matter how many data points are available.
    - `IGNORE`: The alarm state does not change during periods with too few data points to be statistically significant.
  EOF
  type = object({
    operator = string
    threshold = object({
      type = optional(string, "STATIC")
      value = number
    })

    period          = optional(number, 1)
    violation_limit = optional(number, 1)

    missing_data_treatment = optional(string, "MISSING")
    low_sample_percentile_treatment = optional(string)
  })
  nullable = false

  validation {
    condition     = anytrue([
      alltrue([
        var.evaluation.threshold.type == "STATIC",
        contains(["GreaterThanOrEqualToThreshold", "GreaterThanThreshold", "LessThanThreshold", "LessThanOrEqualToThreshold"], var.evaluation.operator),
      ]),
      alltrue([
        var.evaluation.threshold.type == "ANOMALY_DETECTION_BAND",
        contains(["LessThanLowerOrGreaterThanUpperThreshold", "LessThanLowerThreshold", "GreaterThanUpperThreshold"], var.evaluation.operator),
      ]),
    ])
    error_message = "Valid values for `operator` of `evaluation` are `GreaterThanOrEqualToThreshold`, `GreaterThanThreshold`, `LessThanThreshold`, `LessThanOrEqualToThreshold` when `threshold.type` is `STATIC`. Valid values for `operator` of `evaluation` are `LessThanLowerOrGreaterThanUpperThreshold`, `LessThanLowerThreshold`, `GreaterThanUpperThreshold` when `threshold.type` is `ANOMALY_DETECTION_BAND`."
  }

  validation {
    condition     = contains(["STATIC", "ANOMALY_DETECTION_BAND"], var.evaluation.threshold.type)
    error_message = "Valid values for `threshold.type` of `evaluation` are `STATIC`, `ANOMALY_DETECTION_BAND`."
  }

  validation {
    condition     = contains(["MISSING", "IGNORE", "VIOLATION", "NO_VIOLATION"], var.evaluation.missing_data_treatment)
    error_message = "Valid values for `missing_data_treatment` of `evaluation` are `MISSING`, `IGNORE`, `VIOLATION`, `NO_VIOLATION`."
  }

  validation {
    condition     = contains(["EVALUATE", "IGNORE", null], var.evaluation.low_sample_percentile_treatment)
    error_message = "Valid values for `low_sample_percentile_treatment` of `evaluation` are `EVALUATE`, `IGNORE` if not `null`."
  }
}

variable "trigger" {
  description = <<EOF
  (Optional) A configuration of the CloudWatch alarm state trigger. `trigger` as defined below.
    (Optional) `enabled` - Indicate whether actions should be executed during any changes to the alarm state of the metric alarm. Defaults to `true`.
    (Optional) `actions_on_ok` - The set of actions to execute when this alarm transitions to an `OK` state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed.
    (Optional) `actions_on_alarm` - The set of actions to execute when this alarm transitions to the `ALARM` state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed.
    (Optional) `actions_on_insufficient_data` - The set of actions to execute when this alarm transitions to the `INSUFFICIENT_DATA` state from any other state. Each action is specified as an ARN. Up to 5 actions are allowed.
  EOF
  type = object({
    enabled                      = optional(bool, true)
    actions_on_ok                = optional(set(string), [])
    actions_on_alarm             = optional(set(string), [])
    actions_on_insufficient_data = optional(set(string), [])
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
