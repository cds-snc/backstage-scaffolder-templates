resource "aws_route53_zone" ${{ values.product_name | dump }}
${{ values.bucket_name | dump }}
"url_shortener" {
  "${{ values.product_name }}_lambda" 
    name = var.domain
  
    tags = {
      CostCentre = var.billing_code
      Terraform  = true
    }
  }