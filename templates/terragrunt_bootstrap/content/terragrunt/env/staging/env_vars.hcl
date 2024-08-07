inputs = {
    account_id        = ${{ values.staging_account_id | dump }} 
    env               = "staging"
    product_name      = ${{ values.product_name | dump }} 
    cost_center_code  = ${{ values.cost_center_code | dump }} 
    billing_code      = ${{ values.billing_code | dump }} 
    billing_tag_value = ${{ values.billing_tag_value | dump }} 
    domain            = ${{ values.staging_domain | dump }}
  }