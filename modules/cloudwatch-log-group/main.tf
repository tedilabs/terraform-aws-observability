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
# CloudWatch Log Group
###################################################

# INFO: Not supported attributes
# - `name_prefix` (Not used)
resource "aws_cloudwatch_log_group" "this" {
  name         = var.name
  skip_destroy = var.skip_destroy

  retention_in_days = var.retention_in_days
  kms_key_id        = var.encryption_kms_key

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Log Streams for CloudWatch Log Group
###################################################

resource "aws_cloudwatch_log_stream" "this" {
  for_each = var.streams

  name           = each.key
  log_group_name = aws_cloudwatch_log_group.this.name
}
