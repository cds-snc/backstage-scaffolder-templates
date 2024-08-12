variable "billing_code" {
  description = "The billing code to use for cost allocation"
  type        = string
}

variable "domain_name" {
  description = "The domain name to use for the website"
  type        = string
}

module "website" {
  source = "github.com/cds-snc/terraform-modules//simple_static_website?ref=v9.6.3"

  domain_name_source = var.domain_name
  billing_tag_value  = var.billing_code
  single_page_app    = true

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }
}

provider "aws" {
  region = "ca-central-1"
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}
