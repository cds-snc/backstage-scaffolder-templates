terraform {
  source = "../../aws/hosted_zone"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  # Domain configuration for staging
  domain_name = "${var.product_name}-staging.cdssandbox.xyz"  # Update based on your staging domain pattern
  comment     = "Staging hosted zone for ${var.product_name}"
}
