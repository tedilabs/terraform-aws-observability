output "arn" {
  description = "The ARN of the CloudWatch metric alarm."
  value       = aws_cloudwatch_metric_alarm.this.arn
}

output "id" {
  description = "The ID of the CloudWatch metric alarm, which is equivalent to its `name`."
  value       = aws_cloudwatch_metric_alarm.this.id
}

output "name" {
  description = "The name for the CloudWatch metric alarm."
  value       = aws_cloudwatch_metric_alarm.this.alarm_name
}

output "description" {
  description = "The description for the CloudWatch metric alarm."
  value       = aws_cloudwatch_metric_alarm.this.alarm_description
}

output "metric" {
  description = <<EOF
  The configuration of the CloudWatch alarm.
    `namespace` - The namespace for the metric associated with the alarm.
    `name` - The name for the metric associated with the alarm.
    `dimensions` - The dimensions for the metric associated with the alarm.

    `statistic` - The statistic for the metric associated with the alarm.
    `unit` - The unit of measure for the statistic.
    `period` - The length, in seconds, used each time the metric is evaluated.
  EOF
  value       = {
    namespace = aws_cloudwatch_metric_alarm.this.namespace
    name = aws_cloudwatch_metric_alarm.this.metric_name
    dimensions = aws_cloudwatch_metric_alarm.this.dimensions

    statistic = aws_cloudwatch_metric_alarm.this.statistic
    unit = aws_cloudwatch_metric_alarm.this.unit
    period = aws_cloudwatch_metric_alarm.this.period
  }
}

output "evaluation" {
  description = <<EOF
  The configuration of the CloudWatch alarm state evaluation.
    `operator` - The arithmetic operation to use when comparing the specified metric and threshold.
    `threshold` - The configuration for the threshold to compare with the metric or expression.

    `period` - The number of datapoints over which data is compared to the specified threshold.
    `violation_limit` - The number of datapoints that must be violating to trigger the alarm.

    `missing_data_treatment` - How this alarm is to handle missing data points.
    `low_sample_percentile_treatment` - How to treat percentiles with low samples.
  EOF
  value       = {
    operator = aws_cloudwatch_metric_alarm.this.comparison_operator
    threshold = var.evaluation.threshold

    period = aws_cloudwatch_metric_alarm.this.evaluation_periods
    violation_limit = aws_cloudwatch_metric_alarm.this.datapoints_to_alarm

    missing_data_treatment = {
      for k, v in local.missing_data_treatment :
      v => k
    }[aws_cloudwatch_metric_alarm.this.treat_missing_data]
    low_sample_percentile_treatment = try({
      for k, v in local.low_sample_percentile_treatment :
      v => k
    }[aws_cloudwatch_metric_alarm.this.evaluate_low_sample_count_percentiles], null)
  }
}

output "trigger" {
  description = <<EOF
  The configuration of the CloudWatch alarm state trigger.
    `enabled` - Indicate whether actions should be executed during any changes to the alarm state of the metric alarm.
    `actions_on_ok` - The set of actions to execute when this alarm transitions to an `OK` state from any other state.
    `actions_on_alarm` - The set of actions to execute when this alarm transitions to an `ALARM` state from any other state.
    `actions_on_insufficient_data` - The set of actions to execute when this alarm transitions to an `INSUFFICIENT_DATA` state from any other state.
  EOF
  value       = {
    enabled = aws_cloudwatch_metric_alarm.this.actions_enabled
    actions_on_ok = coalesce(aws_cloudwatch_metric_alarm.this.ok_actions, toset([]))
    actions_on_alarm = coalesce(aws_cloudwatch_metric_alarm.this.alarm_actions, toset([]))
    actions_on_insufficient_data = coalesce(aws_cloudwatch_metric_alarm.this.insufficient_data_actions, toset([]))
  }
}

output "zzz" {
  description = "The list of log streams for the log group."
  value = {
    for k, v in aws_cloudwatch_metric_alarm.this :
    k => v
    if !contains(["id", "arn", "alarm_name", "alarm_description", "actions_enabled", "ok_actions", "alarm_actions", "insufficient_data_actions", "metric_name", "namespace", "treat_missing_data", "evaluate_low_sample_count_percentiles", "tags", "tags_all", "datapoints_to_alarm", "evaluation_periods", "comparison_operator", "threshold", "period", "unit", "statistic", "dimensions"], k)
  }
}
