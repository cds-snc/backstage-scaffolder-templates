terraform {
  source = "../../aws/hosted_zone"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  # Domain configuration for production
  domain_name = "${var.product_name}.alpha.canada.ca"  # Update based on your production domain pattern
  comment     = "Production hosted zone for ${var.product_name}"
}
