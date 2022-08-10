provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "this" {}

###################################################
# Resource Policy for CloudWatch Logs
###################################################

module "log_policy" {
  source = "../../modules/cloudwatch-log-policy"
  # source  = "tedilabs/observability/aws//modules/cloudwatch-log-policy"
  # version = "~> 0.1.0"

  name    = "es"
  service = "es.amazonaws.com"

  statements = [
    {
      log_groups        = ["/aws/es/*"]
      account_whitelist = [data.aws_caller_identity.this.account_id]
    }
  ]
}
