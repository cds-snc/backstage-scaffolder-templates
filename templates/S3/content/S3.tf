  module "S3" {
    source = "github.com/cds-snc/terraform-modules//S3?ref=v9.2.4"
 
    bucket_name       = ${{ values.bucket_name | dump }}
    billing_tag_value = ${{ values.billing_tag_value | dump }}
  }