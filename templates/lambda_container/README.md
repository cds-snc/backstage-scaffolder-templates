# Lambda container image function (Backstage template)

Backstage software template that scaffolds the Terraform for an AWS Lambda function
deployed from a container image in ECR, fronted by CloudFront.

It wraps the CDS [`terraform-modules//lambda`](https://github.com/cds-snc/terraform-modules/tree/main/lambda)
module and opens the PR for you. The template only produces a Terraform fragment — it is
designed to be merged into an existing Terraform/Terragrunt environment, not to stand on its own.

## What it creates

Files are written into `<terraformLoc>/lambda/` in the target repo:

| File | Contents |
|------|----------|
| `lambda.tf` | The `lambda` module, a `latest` alias, the function URL, and the invoke permissions. Also derives the ECR URL/ARN from the repository name. |
| `output.tf` | `function_arn`, `function_name`, `invoke_arn`, `function_url`. |

Resources provisioned:

- Lambda function (container image) via the CDS `lambda` module, with Lambda Insights enabled.
- `aws_lambda_alias` `latest`. 
- `aws_lambda_function_url` with `authorization_type = "NONE"`.
- Two `aws_lambda_permission` resources that restrict invocation to CloudFront only, scoped
  to a specific distribution in the current account.

## Requirements

This template assumes the following already exist / are provided by the surrounding environment.
Have these ready before running it:

1. An existing ECR repository holding the container image.
   - You supply its name in the form. The URL and ARN are constructed automatically as:
     - URL — `<account_id>.dkr.ecr.<region>.amazonaws.com/<name>`
     - ARN — `arn:aws:ecr:<region>:<account_id>:repository/<name>`
   - The name is not validated — a wrong name produces a URL/ARN that points at nothing, and
     the Lambda will fail to pull the image at runtime. Double-check it.
   - For ECRs created with the [ECR template](../ecr).
   - An image must be pushed to the repository at the tag you specify.

2. An existing CloudFront distribution.
   - You supply its distribution ID in the form (e.g. `E1A2B3C4D5E6F7`).
   - Invocation of the function URL is locked to this distribution
     (`principal = "cloudfront.amazonaws.com"` + a `source_arn` scoped to it). Anyone hitting the
     function URL directly is denied — traffic must come through CloudFront.
   - Because the ID is required up front, the distribution must exist *before* scaffolding. If you
     create the distribution and the Lambda in the same change, scaffold the distribution first.

3. A Terraform/Terragrunt environment to merge into, providing:
   - The AWS provider and remote state/backend config — this template ships neither.

## Inputs (form fields)

| Field | Required | Description |
|-------|----------|-------------|
| `product_name` | ✅ | Product name; used to name the function (`<product_name>-lambda`) and the Terraform resources. |
| `billing_code` | ✅ | Billing/cost-centre tag value. |
| `ecr_repository_name` | ✅ | Name of the existing ECR repository. URL and ARN are derived from it. |
| `ecr_tag` | ✅ | Image tag to deploy (e.g. `latest`). |
| `cloudfront_distribution_id` | ✅ | ID of the existing CloudFront distribution allowed to invoke the function. |
| `memory` | optional | Function memory in MB (module default `128`). |
| `timeout` | optional | Function timeout in seconds (module default `3`, max `900`). |
| `repoUrl` | ✅ | Target GitHub repo (cds-snc) where the PR is opened. |
| `terraformLoc` | ✅ | Directory the Terraform is written into, e.g. `terragrunt/aws/`. Files land in `<terraformLoc>/lambda/`. |

## How to use

1. In Backstage, open Create… → "Create an Lambda container image function instance".
2. Fill in the form. Make sure the ECR repository, the pushed image, and the CloudFront distribution
   from [Requirements](#requirements) already exist.
3. Submit. The template opens a pull request titled
   `🥡 Create AWS lambda function with Container image for <product_name>` against the chosen repo,
   on branch `backstage_template_<product_name>_lambda`.
4. Review and complete the PR before merging.
5. Merge, then `terraform`/`terragrunt apply` through your normal pipeline.

## References

- CDS Lambda module: <https://github.com/cds-snc/terraform-modules/tree/main/lambda>
- Companion ECR template: [`templates/ecr`](../ecr)
