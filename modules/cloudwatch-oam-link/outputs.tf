output "arn" {
  description = "The ARN of the CloudWatch OAM link."
  value       = aws_oam_link.this.arn
}

output "id" {
  description = "The ID of the CloudWatch OAM link."
  value       = aws_oam_link.this.link_id
}

output "sink" {
  description = "The information of the sink for this link."
  value = {
    id  = aws_oam_link.this.sink_identifier
    arn = aws_oam_link.this.sink_arn
  }
}

output "name" {
  description = "The name of CloudWatch OAM link."
  value       = local.metadata.name
}

output "account_label" {
  description = "A label to help identify your source account."
  value       = aws_oam_link.this.label
}

output "telemetry_types" {
  description = "A set of the telemetry types that the source account shares with the monitoring account."
  value       = aws_oam_link.this.resource_types
}
