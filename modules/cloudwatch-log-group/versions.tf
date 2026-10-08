terraform {
  required_version = ">= 1.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.60"
    }
    telemetry = {
      source  = "tedilabs/telemetry"
      version = ">= 0.1.1"
    }
  }
}
