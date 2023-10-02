locals {
  metadata = {
    package = "terraform-aws-observability"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

locals {
  aggregation_statistics = ["SampleCount", "Average", "Sum", "Minimum", "Maximum"]

  missing_data_treatment = {
    "MISSING"      = "missing"
    "IGNORE"       = "ignore"
    "VIOLATION"    = "breaching"
    "NO_VIOLATION" = "notBreaching"
  }
  low_sample_percentile_treatment = {
    "EVALUATE" = "evaluate"
    "IGNORE"   = "ignore"
  }
}


###################################################
# CloudWatch Metric Alarm
###################################################

# threshold_metric
# extended_statistic - (Optional) The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100.

# metric_query (Optional) Enables you to create an alarm based on a metric math expression. You may specify at most 20.
resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name        = var.name
  alarm_description = var.description


  ## Data
  # Metric
  namespace   = var.metric.namespace
  metric_name = var.metric.name
  dimensions  = var.metric.dimensions

  statistic = var.metric.statistic
  unit      = var.metric.unit
  period    = var.metric.period


  ## Evaluation
  comparison_operator = var.evaluation.operator
  threshold = (var.evaluation.threshold.type == "STATIC"
    ? var.evaluation.threshold.value
    : null
  )

  evaluation_periods  = var.evaluation.period
  datapoints_to_alarm = var.evaluation.violation_limit

  treat_missing_data = local.missing_data_treatment[var.evaluation.missing_data_treatment]
  evaluate_low_sample_count_percentiles = (contains(local.aggregation_statistics, var.metric.statistic)
    ? null
    : local.low_sample_percentile_treatment[var.evaluation.low_sample_percentile_treatment]
  )


  ## Trigger
  actions_enabled = var.trigger.enabled

  ok_actions                = var.trigger.actions_on_ok
  alarm_actions             = var.trigger.actions_on_alarm
  insufficient_data_actions = var.trigger.actions_on_insufficient_data


  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
