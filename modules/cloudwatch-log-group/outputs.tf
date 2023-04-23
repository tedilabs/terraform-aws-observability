output "arn" {
  description = "The ARN of the CloudWatch log group."
  value       = aws_cloudwatch_log_group.this.arn
}

output "id" {
  description = "The ID of the CloudWatch log group."
  value       = aws_cloudwatch_log_group.this.id
}

output "name" {
  description = "The name of CloudWatch log group."
  value       = aws_cloudwatch_log_group.this.name
}

output "retention_in_days" {
  description = "The number of days to retain log events in the log group."
  value       = aws_cloudwatch_log_group.this.retention_in_days
}

output "encryption_kms_key" {
  description = "The ARN of the KMS Key for log data encryption."
  value       = aws_cloudwatch_log_group.this.kms_key_id
}

output "streams" {
  description = "The list of log streams for the log group."
  value = {
    for name, stream in aws_cloudwatch_log_stream.this :
    name => {
      arn  = stream.arn
      name = stream.name
    }
  }
}

output "metric_filters" {
  description = "The list of metric filters for the log group."
  value = {
    for name, filter in aws_cloudwatch_log_metric_filter.this :
    name => {
      id      = filter.id
      name    = filter.name
      pattern = filter.pattern
      metric = {
        namespace = one(filter.metric_transformation[*].namespace)
        name      = one(filter.metric_transformation[*].name)

        value         = one(filter.metric_transformation[*].value)
        default_value = one(filter.metric_transformation[*].default_value)
        dimensions    = one(filter.metric_transformation[*].dimensions)
        unit          = one(filter.metric_transformation[*].unit)
      }
    }
  }
}
