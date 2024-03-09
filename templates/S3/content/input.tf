###
# Common tags
###
variable "billing_tag_value" {
  description = "(Rquired) The value of the billing tag"
  type        = string
}

variable "bucket_name" {
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}