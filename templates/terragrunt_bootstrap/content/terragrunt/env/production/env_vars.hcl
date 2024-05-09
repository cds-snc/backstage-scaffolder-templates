inputs = {
    account_id        = ${{ values.account_id | dump }} 
    env               = "production"
    product_name      = ${{ values.product_name | dump }} 
    cost_center_code  = ${{ values.cost_center_code | dump }} 
    billing_code      = ${{ values.billing_code | dump }} 
    billing_tag_value = ${{ values.billing_tag_value | dump }} 
    domain            = ${{ values.domain | dump }}
  }