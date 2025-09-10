output "arn" {
  description = "The ARN of the CloudWatch OAM sink."
  value       = aws_oam_sink.this.arn
}

output "id" {
  description = "The ID of the CloudWatch OAM sink."
  value       = aws_oam_sink.this.sink_id
}

output "name" {
  description = "The name of CloudWatch OAM sink."
  value       = aws_oam_sink.this.name
}

output "telemetry_types" {
  description = "A set of the telemetry types can be shared with it."
  value       = var.telemetry_types
}

output "allowed_source_accounts" {
  description = "A list of the IDs of AWS accounts allowed to share data with this monitoring account."
  value       = var.allowed_source_accounts
}

output "allowed_source_organizations" {
  description = "A list of the organization IDs of AWS accounts allowed to share data with this monitoring account."
  value       = var.allowed_source_organizations
}

output "allowed_source_organization_paths" {
  description = "A list of the organization paths of AWS accounts allowed to share data with this monitoring account."
  value       = var.allowed_source_organization_paths
}

output "resource_group" {
  description = "The resource group created to manage resources in this module."
  value = merge(
    {
      enabled = var.resource_group.enabled && var.module_tags_enabled
    },
    (var.resource_group.enabled && var.module_tags_enabled
      ? {
        arn  = module.resource_group[0].arn
        name = module.resource_group[0].name
      }
      : {}
    )
  )
}
