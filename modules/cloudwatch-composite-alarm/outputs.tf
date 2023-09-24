output "arn" {
  description = "The ARN of the CloudWatch composite alarm."
  value       = aws_cloudwatch_composite_alarm.this.arn
}

output "id" {
  description = "The ID of the CloudWatch composite alarm, which is equivalent to its `name`."
  value       = aws_cloudwatch_composite_alarm.this.id
}

output "name" {
  description = "The name for the CloudWatch composite alarm."
  value       = aws_cloudwatch_composite_alarm.this.alarm_name
}

output "description" {
  description = "The description for the CloudWatch composite alarm."
  value       = aws_cloudwatch_composite_alarm.this.alarm_description
}

output "rule" {
  description = "The expression that specifies which other alarms are to be evaluated to determine this composite alarm's state."
  value       = aws_cloudwatch_composite_alarm.this.alarm_rule
}

output "actions_enabled" {
  description = "Indicate whether actions should be executed during any changes to the alarm state of the composite alarm."
  value       = aws_cloudwatch_composite_alarm.this.actions_enabled
}

output "actions_on_ok" {
  description = "The set of actions to execute when this alarm transitions to an `OK` state from any other state."
  value       = aws_cloudwatch_composite_alarm.this.ok_actions
}

output "actions_on_alarm" {
  description = "The set of actions to execute when this alarm transitions to an `ALARM` state from any other state."
  value       = aws_cloudwatch_composite_alarm.this.alarm_actions
}

output "actions_on_insufficient_data" {
  description = "The set of actions to execute when this alarm transitions to an `INSUFFICIENT_DATA` state from any other state."
  value       = aws_cloudwatch_composite_alarm.this.insufficient_data_actions
}


output "zzz" {
  description = "The list of log streams for the log group."
  value = {
    for k, v in aws_cloudwatch_composite_alarm.this :
    k => v
    if !contains(["id", "arn", "alarm_name", "alarm_description", "actions_enabled", "ok_actions", "alarm_actions", "insufficient_data_actions"], k)
  }
}
