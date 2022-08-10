locals {
  metadata = {
    package = "terraform-aws-observability"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
}


###################################################
# Resource Policy of CloudWatch Logs
###################################################

resource "aws_cloudwatch_log_resource_policy" "this" {
  policy_name = var.name

  policy_document = data.aws_iam_policy_document.this.json
}
