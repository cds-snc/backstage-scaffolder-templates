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

variable "availability_zones" {
  description = "The number of availability zones to use"
  type        = number
  default     = 2
}

variable "cidrsubnet_newbits" {
  description = "The number of additional bits with which to extend the cidr subnet prefix"
  type        = number
  default     = 8
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true 
}

variable "allow_https_request_in" {
  description = "Allow HTTPS connections on port 443 in from the internet"
  type        = bool
  default     = true
}

variable "allow_https_request_in_response" {
  description = "Allow a response back to the internet in reply to a request"
  type        = bool
  default     = true
}

variable "allow_https_request_out" {
  description = "Allow HTTPS connections on port 443 out to the internet"
  type        = bool
  default     = true
}

variable "allow_https_request_out_response" {
  description = "Allow a response back from the internet in reply to a request"
  type        = bool
  default     = true
}

variable "enable_flow_log" {
  description = "Whether or not to enable VPC Flow Logs"
  type        = bool
  default     = true
}
