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
      name    = "event-count"
      pattern = ""

      metric = {
        namespace     = "Custom/Example"
        name          = "EventCount"
        value         = "1"
        default_value = "0"
        unit          = "None"
      }
    },
    {
      name    = "error-count"
      pattern = "Error"

      metric = {
        namespace     = "Custom/Example"
        name          = "ErrorCount"
        value         = "1"
        default_value = "0"
        unit          = "None"
      }
    },
    {
      name    = "apache-404-count"
      pattern = "[ip, id, user, timestamp, request, status_code=404, size]"

      metric = {
        namespace     = "Custom/Example"
        name          = "ApacheNotFoundErrorCount"
        value         = "1"
        default_value = "0"
        unit          = "None"
      }
    },
    {
      name    = "apache-bytes-transferred"
      pattern = "[ip, id, user, timestamp, request, status_code, size]"

      metric = {
        namespace = "Custom/Example"
        name      = "ApacheBytesTransferred"
        value     = "$size"
        unit      = "Bytes"
        dimensions = {
          "IP" = "$ip"
        }
      }
    },
  ]

  tags = {
    "project" = "terraform-aws-observability-examples"
  }
}
