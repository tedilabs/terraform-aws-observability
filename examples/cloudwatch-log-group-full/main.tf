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

  name         = "/tedilabs/test"
  skip_destroy = false

  retention_in_days  = 7
  encryption_kms_key = null

  streams = [
    "test-stream-1",
    "test-stream-2",
  ]

  metric_filters = [
    {
      name    = "error-filter"
      pattern = "err"

      metric = {
        namespace     = "Custom/Test"
        name          = "Errors"
        value         = "1"
        default_value = "0"
        unit          = "None"
      }
    }
  ]

  tags = {
    "project" = "terraform-aws-observability-examples"
  }
}
