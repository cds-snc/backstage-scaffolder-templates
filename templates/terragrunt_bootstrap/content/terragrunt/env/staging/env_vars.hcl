locals {
    billing_code = ${{ values.billing_code | dump }}
    domain = ${{ values.domain | dump }}
    account_id = ${{ values.account_id | dump }}
    product_name = ${{ values.product_name | dump }}
    billing_tag_value = ${{ values.billing_tag_value | dump }}
    cost_center_code = ${{ values.cost_center_code | dump }}
  }

inputs = {
    account_id        = local.account_id 
    env               = "staging"
    product_name      = local.product_name
    cost_center_code  = local.cost_center_code
    billing_code	  = local.billing_code
    billing_tag_value = local.billing_tag_value
    domain            = local.domain
  }