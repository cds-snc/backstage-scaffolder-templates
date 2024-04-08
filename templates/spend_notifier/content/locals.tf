locals {
  common_tags = {
    CostCentre = ${{ values.billing_tag_value | dump}}
    Terraform  = "true"
  }
}