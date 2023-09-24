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


###################################################
# CloudWatch Composite Alarm
###################################################

resource "aws_cloudwatch_composite_alarm" "this" {
  alarm_name        = var.name
  alarm_description = var.description
  alarm_rule        = var.rule


  ## Actions
  actions_enabled = var.actions_enabled

  ok_actions = var.actions_on_ok
  alarm_actions = var.actions_on_alarm
  insufficient_data_actions = var.actions_on_insufficient_data

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
