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
# CloudWatch OAM Link
###################################################

resource "aws_oam_link" "this" {
  sink_identifier = var.sink

  label_template = var.account_label
  resource_types = var.telemetry_types

  dynamic "link_configuration" {
    for_each = (var.log_group_configuration.filter != "" || var.metric_configuration.filter != "") ? ["go"] : []

    content {
      dynamic "log_group_configuration" {
        for_each = var.log_group_configuration.filter != "" ? [var.log_group_configuration] : []

        content {
          filter = log_group_configuration.value.filter
        }
      }
      dynamic "metric_configuration" {
        for_each = var.metric_configuration.filter != "" ? [var.metric_configuration] : []

        content {
          filter = metric_configuration.value.filter
        }
      }
    }
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
