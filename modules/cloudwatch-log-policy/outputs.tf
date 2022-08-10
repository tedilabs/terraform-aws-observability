output "name" {
  description = "The name of CloudWatch Logs resource policy."
  value       = aws_cloudwatch_log_resource_policy.this.policy_name
}

output "service" {
  description = "The identity of the AWS service principal which is allowed to delivery logs to this account."
  value       = var.service
}

output "statements" {
  description = "The list of statements for CloudWatch Logs resource policy."
  value = {
    for idx, statement in var.statements :
    "${var.name}-${idx}" => {
      log_groups = statement.log_groups

      account_whitelist  = try(statement.account_whitelist, null)
      resource_whitelist = try(statement.resource_whitelist, null)
    }
  }
}
