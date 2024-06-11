resource "aws_route53_zone" ${{ values.product_name | dump }} {
    name = var.domain
  
    tags = {
      CostCentre = var.billing_code
      Terraform  = true
    }
  }