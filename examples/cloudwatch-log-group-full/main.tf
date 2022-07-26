provider "aws" {
  region = "us-east-1"
}


###################################################
# Log Group for CloudWatch Logs
###################################################

module "log_group" {
  source = "../../modules/cloudwatch-log-group"
  # source  = "tedilabs/observability/aws//modules/cloudwatch-log-group"
  # version = "~> 0.1.0"

  name = "/tedilabs/test"

  retention_in_days  = 7
  encryption_kms_key = null

  streams = [
    "test-stream-1",
    "test-stream-2",
  ]

  tags = {
    "project" = "terraform-aws-secret-examples"
  }
}
