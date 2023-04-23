# terraform-aws-observability

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/tedilabs/terraform-aws-observability?color=blue&sort=semver&style=flat-square)
![GitHub](https://img.shields.io/github/license/tedilabs/terraform-aws-observability?color=blue&style=flat-square)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)

Terraform module which creates observability related resources on AWS.

- [cloudwatch-log-group](./modules/cloudwatch-log-group)
- [cloudwatch-log-policy](./modules/cloudwatch-log-policy)
- [cloudwatch-oam-link](./modules/cloudwatch-oam-link)
- [cloudwatch-oam-sink](./modules/cloudwatch-oam-sink)


## Target AWS Services

Terraform Modules from [this package](https://github.com/tedilabs/terraform-aws-observability) were written to manage the following AWS Services with Terraform.

- **AWS CloudWatch**
  - Alarms (Comming soon!)
  - Logs
    - Log Groups
    - Resource Policy
  - Metrics (Comming soon!)
  - OAM (Observability Access Manager)
    - Sink (Monitoring Account)
    - Link (Source Account)


## Examples

### AWS CloudWatch

#### Logs

- [CloudWatch Log Group Simple](./examples/cloudwatch-log-group-simple)
- [CloudWatch Log Group Full](./examples/cloudwatch-log-group-full)
- [CloudWatch Log Policy for OpenSearch](./examples/cloudwatch-log-policy-es)
- [CloudWatch Log Policy for Route53](./examples/cloudwatch-log-policy-route53)

#### OAM (Observability Access Manager)

- [CloudWatch OAM Cross Account Observability](./examples/cloudwatch-oam-cross-account-observability)


## Self Promotion

Like this project? Follow the repository on [GitHub](https://github.com/tedilabs/terraform-aws-observability). And if you're feeling especially charitable, follow **[posquit0](https://github.com/posquit0)** on GitHub.


## License

Provided under the terms of the [Apache License](LICENSE).

Copyright © 2022-2023, [Byungjin Park](https://www.posquit0.com).
