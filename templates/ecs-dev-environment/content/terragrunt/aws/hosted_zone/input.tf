variable "product_name" {
  description = "The name of the product you are deploying."
  type        = string
}

variable "billing_code" {
  description = "The billing code to tag our resources with"
  type        = string
}

variable "billing_tag_value" {
  description = "The value we use to track billing"
  type        = string
}

variable "env" {
  description = "The current running environment"
  type        = string
}

variable "region" {
  description = "The current AWS region"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the hosted zone"
  type        = string
}

variable "comment" {
  description = "A comment for the hosted zone"
  type        = string
  default     = ""
}
