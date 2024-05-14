module "${{ values.product_name }}_lambda" {
    source                 = "github.com/cds-snc/terraform-modules//lambda?ref=v9.4.4"
    name                   = "${{ values.product_name }}-lambda"
    billing_tag_value      = ${{ values.billing_code | dump }}
    ecr_arn                = ${{ values.ecr_arn | dump }}
    enable_lambda_insights = true
    image_uri              = "${{ values.ecr_repository_url }}:${{ values.ecr_tag }}"
    memory                 = ${{ values.memory }} 
    timeout                = ${{ values.timeout }} 
  }
  
  resource "aws_lambda_alias" "${{ values.product_name }}_lambda_alias" {
    name             = "latest"
    description      = "The latest version of the lambda function"
    function_name    = module.${{ values.product_name }}.function_name
    function_version = "1"
  
    lifecycle {
      ignore_changes = [
        function_version,
        routing_config
      ]
    }
  }
  
  resource "aws_lambda_function_url" "${{ values.product_name }}_lambda_url" {
    function_name      = module.${{ values.product_name }}.function_name
    qualifier          = aws_lambda_alias.${{ values.product_name }}_lambda_alias.name

    authorization_type = "NONE"
  }