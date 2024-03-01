terraform {
  source = "."
}

locals {
  billing_code = ${{ values.billing_code | dump }}
  domain_name = ${{ values.domain_name | dump }}
}

# DO NOT CHANGE ANYTHING BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING

inputs = {
  billing_code = local.billing_code
  domain_name = local.domain_name
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    encrypt             = true
    bucket              = "${local.billing_code}-tf"
    dynamodb_table      = "terraform-state-lock-dynamo"
    region              = "ca-central-1"
    key                 = "${path_relative_to_include()}/terraform.tfstate"
    s3_bucket_tags      = { CostCenter : local.billing_code }
    dynamodb_table_tags = { CostCenter : local.billing_code }
  }
}