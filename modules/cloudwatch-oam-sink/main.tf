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
# CloudWatch OAM Sink
###################################################

resource "aws_oam_sink" "this" {
  name = var.name

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# CLoudWatch OAM Sink Policy
###################################################

locals {
  source_accounts_statement = {
    Effect = "Allow"
    Principal = {
      "AWS" = var.allowed_source_accounts
    }
    Action   = ["oam:CreateLink", "oam:UpdateLink"]
    Resource = "*"
    Condition = {
      "ForAllValues:StringEquals" = {
        "oam:ResourceTypes" = var.telemetry_types
      }
    }
  }
  source_organizations_statement = {
    Effect    = "Allow"
    Principal = "*"
    Action    = ["oam:CreateLink", "oam:UpdateLink"]
    Resource  = "*"
    Condition = {
      "ForAllValues:StringEquals" = {
        "oam:ResourceTypes" = var.telemetry_types
      }
      "ForAnyValue:StringEquals" = {
        "aws:PrincipalOrgID" = var.allowed_source_organizations
      }
    }
  }
  source_organization_paths_statement = {
    Effect    = "Allow"
    Principal = "*"
    Action    = ["oam:CreateLink", "oam:UpdateLink"]
    Resource  = "*"
    Condition = {
      "ForAllValues:StringEquals" = {
        "oam:ResourceTypes" = var.telemetry_types
      }
      "ForAnyValue:StringEquals" : {
        "aws:PrincipalOrgPaths" : var.allowed_source_organization_paths
      }
    }
  }
  policy_required = length(concat(
    var.allowed_source_accounts,
    var.allowed_source_organizations,
    var.allowed_source_organization_paths,
  )) > 0
}

resource "aws_oam_sink_policy" "this" {
  count = local.policy_required ? 1 : 0

  sink_identifier = aws_oam_sink.this.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat(
      length(var.allowed_source_accounts) > 0 ? [local.source_accounts_statement] : [],
      length(var.allowed_source_organizations) > 0 ? [local.source_organizations_statement] : [],
      length(var.allowed_source_organization_paths) > 0 ? [local.source_organization_paths_statement] : [],
    )
  })
}
