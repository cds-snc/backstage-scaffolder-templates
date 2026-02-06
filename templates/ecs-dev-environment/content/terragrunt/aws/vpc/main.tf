module "vpc" {
  source = "github.com/cds-snc/terraform-modules//vpc?ref=v9.6.8"

  name                              = "${var.product_name}-${var.env}"
  availability_zones                = var.availability_zones
  cidrsubnet_newbits               = var.cidrsubnet_newbits
  single_nat_gateway               = var.single_nat_gateway
  billing_tag_value                = var.billing_tag_value
  
  # HTTPS traffic configuration
  allow_https_request_in           = var.allow_https_request_in
  allow_https_request_in_response  = var.allow_https_request_in_response
  allow_https_request_out          = var.allow_https_request_out
  allow_https_request_out_response = var.allow_https_request_out_response
  
  # Enable VPC Flow Logs for monitoring
  enable_flow_log = var.enable_flow_log
}
