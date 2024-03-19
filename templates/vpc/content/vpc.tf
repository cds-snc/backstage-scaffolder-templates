#
# VPC
#

module "vpc" {
  source            = "github.com/cds-snc/terraform-modules//vpc?ref=v9.2.5"
  name              = ${{ values.vpc_name | dump }}
  billing_tag_value = ${{ values.billing_tag_value| dump }} 
}