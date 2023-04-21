provider "aws" {
  alias  = "monitoring"
  region = "us-east-1"
}

provider "aws" {
  alias  = "source"
  region = "us-east-1"
}

data "aws_caller_identity" "monitoring" {
  provider = aws.monitoring
}

data "aws_caller_identity" "source" {
  provider = aws.source
}


###################################################
# CloudWatch OAM Sink
###################################################

module "sink" {
  source = "../../modules/cloudwatch-oam-sink"
  # source  = "tedilabs/observability/aws//modules/cloudwatch-oam-sink"
  # version = "~> 0.2.0"

  providers = {
    aws = aws.monitoring
  }

  name = "monitoring"

  ## Source Accounts
  telemetry_types = ["AWS::CloudWatch::Metric", "AWS::Logs::LogGroup", "AWS::XRay::Trace"]

  allowed_source_accounts           = [data.aws_caller_identity.source.account_id]
  allowed_source_organizations      = []
  allowed_source_organization_paths = []

  tags = {
    "project" = "terraform-aws-observability-examples"
  }
}


###################################################
# CloudWatch OAM Link
###################################################

module "link" {
  source = "../../modules/cloudwatch-oam-link"
  # source  = "tedilabs/observability/aws//modules/cloudwatch-oam-link"
  # version = "~> 0.2.0"

  providers = {
    aws = aws.source
  }

  sink = module.sink.arn
  name = "source"

  account_label   = "$AccountName"
  telemetry_types = ["AWS::CloudWatch::Metric", "AWS::Logs::LogGroup", "AWS::XRay::Trace"]

  tags = {
    "project" = "terraform-aws-observability-examples"
  }
}
