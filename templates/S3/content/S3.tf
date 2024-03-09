  module "S3" {
    source = "github.com/cds-snc/terraform-modules//S3?ref=v9.2.4"
 
    bucket_name = var.bucket_name
    billing_tag_value  = var.billing_tag_value
  }