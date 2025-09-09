resource "aws_route53_zone" "${var.product_name}_hosted_zone" {
  name    = var.domain_name
  comment = var.comment != "" ? var.comment : "Hosted zone for ${var.product_name} ${var.env} environment"

  tags = {
    Name       = "${var.product_name}-${var.env}-hosted-zone"
    CostCentre = var.billing_tag_value
    Terraform  = true
    Domain     = var.domain_name
  }
}

# Optional: Create a health check for the domain (useful for monitoring)
resource "aws_route53_health_check" "${var.product_name}_health_check" {
  count                            = var.env == "production" ? 1 : 0
  fqdn                            = var.domain_name
  port                            = 443
  type                            = "HTTPS"
  resource_path                   = "/health"
  failure_threshold               = "3"
  request_interval                = "30"
  cloudwatch_insufficient_data_health_status = "Failure"

  tags = {
    Name       = "${var.product_name}-${var.env}-health-check"
    CostCentre = var.billing_tag_value
    Terraform  = true
  }
}
