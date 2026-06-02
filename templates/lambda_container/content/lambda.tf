module "${{ values.product_name }}_lambda" {
    source                 = "github.com/cds-snc/terraform-modules//lambda?ref=v9.4.4"
    name                   = "${{ values.product_name }}-lambda"
    billing_tag_value      = ${{ values.billing_code | dump }}
    ecr_arn                = local.ecr_repository_arn
    enable_lambda_insights = true
    image_uri              = "${local.ecr_repository_url}:${{ values.ecr_tag }}"
    memory                 = ${{ values.memory }} 
    timeout                = ${{ values.timeout }} 
  }
  
resource "aws_lambda_alias" "${{ values.product_name }}_lambda_alias" {
    name             = "latest"
    description      = "The latest version of the lambda function"
    function_name    = module.${{ values.product_name }}_lambda.function_name
    function_version = "1"
  
    lifecycle {
      ignore_changes = [
        function_version,
      ]
    }
  }
  
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
    ecr_repository_name = "${{ values.ecr_repository_name }}"
    ecr_repository_url  = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${local.ecr_repository_name}"
    ecr_repository_arn  = "arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/${local.ecr_repository_name}"
}

resource "aws_lambda_function_url" "${{ values.product_name }}_lambda_url" {
    function_name      = module.${{ values.product_name }}_lambda.function_name
    qualifier          = aws_lambda_alias.${{ values.product_name }}_lambda_alias.name

    authorization_type = "NONE"
  }

resource "aws_lambda_permission" "${{ values.product_name }}_invoke_function_url" {
    statement_id           = "AllowInvokeFunctionUrl"
    action                 = "lambda:InvokeFunctionUrl"
    function_name          = module.${{ values.product_name }}_lambda.function_name
    function_url_auth_type = "NONE"
    principal              = "cloudfront.amazonaws.com"
    source_arn             = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${{ values.cloudfront_distribution_id }}"
}

resource "aws_lambda_permission" "${{ values.product_name }}_invoke_function" {
  statement_id  = "AllowInvokeFunction"
  action        = "lambda:InvokeFunction"
  function_name = module.${{ values.product_name }}_lambda.function_name
  principal     = "cloudfront.amazonaws.com"
  source_arn    = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${{ values.cloudfront_distribution_id }}"
}