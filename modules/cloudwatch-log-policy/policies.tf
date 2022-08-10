data "aws_caller_identity" "this" {}
data "aws_region" "this" {}

locals {
  account_id = data.aws_caller_identity.this.account_id
  region     = data.aws_region.this.name

  service_actions = {
    "es.amazonaws.com" = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]
    "route53.amazonaws.com" = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

###################################################
# Resource Policy
###################################################

data "aws_iam_policy_document" "this" {
  dynamic "statement" {
    for_each = var.statements

    content {
      sid = "${var.name}-${statement.key}"

      actions = local.service_actions[var.service]

      resources = [
        for log_group in statement.value.log_groups :
        "arn:aws:logs:${local.region}:${local.account_id}:log-group:${log_group}"
      ]

      principals {
        identifiers = [var.service]
        type        = "Service"
      }

      dynamic "condition" {
        for_each = try([statement.value.account_whitelist], [])

        content {
          test     = "StringEquals"
          variable = "aws:SourceAccount"
          values   = condition.value
        }
      }

      dynamic "condition" {
        for_each = try([statement.value.resource_whitelist], [])

        content {
          test     = "ArnLike"
          variable = "aws:SourceArn"
          values   = condition.value
        }
      }
    }
  }
}
