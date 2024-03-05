  locals {
    vars = read_terragrunt_config("../env_vars.hcl")
    billing_code = ${{ values.billing_code | dump }}
    domain = ${{ values.domain | dump }}
    account_id = ${{ values.account_id | dump }}
    product_name = ${{ values.product_name | dump }}
    billing_tag_value = ${{ values.billing_tag_value | dump }}
    cost_center_code = ${{ values.cost_center_code | dump }}
  }
  
  # DO NOT CHANGE ANYTHING BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING
  
  inputs = {
    product_name                 = "${local.product_name}" 
    account_id                   = "${local.account_id}"
    domain                       = "${local.domain}"
    env                          = "${local.vars.inputs.env}"
    region                       = "ca-central-1"
    billing_code                 = "${local.inputs.cost_center_code}"
    billing_tag_value            = "${local.inputs.billing_tag_value}"
    cbs_satellite_bucket_name    = "cbs-satellite-${local.inputs.account_id}"
  }
  
  generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite"
    contents  = file("./common/provider.tf")
  
  }
  
  generate "common_variables" {
    path      = "common_variables.tf"
    if_exists = "overwrite"
    contents  = file("./common/common_variables.tf")
  }
  
  remote_state {
    backend = "s3"
    generate = {
      path      = "backend.tf"
      if_exists = "overwrite_terragrunt"
    }
    config = {
      encrypt             = true
      bucket              = "${local.inputs.cost_center_code}-tf"
      dynamodb_table      = "terraform-state-lock-dynamo"
      region              = "ca-central-1"
      key                 = "${path_relative_to_include()}/terraform.tfstate"
      s3_bucket_tags      = { CostCentre : local.inputs.cost_center_code }
      dynamodb_table_tags = { CostCentre : local.inputs.cost_center_code }
    }
  }