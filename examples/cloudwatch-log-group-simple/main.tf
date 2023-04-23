provider "aws" {
  region = "us-east-1"
}


###################################################
# Log Group for CloudWatch Logs
###################################################

module "log_group" {
  source = "../../modules/cloudwatch-log-group"
  # source  = "tedilabs/observability/aws//modules/cloudwatch-log-group"
  # version = "~> 0.2.0"

  name = "/tedilabs/test"

  streams = [
    "test-stream-1",
    "test-stream-2",
  ]

  tags = {
    "project" = "terraform-aws-observability-examples"
  }
}
