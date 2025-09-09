terraform {
  source = "../../aws/vpc"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  # VPC configuration for staging
  availability_zones     = 2                    # Use 2 AZs for cost optimization in staging
  cidrsubnet_newbits    = 8                     # Subnet sizing
  single_nat_gateway    = true                  # Use single NAT gateway for cost savings in staging
  
  # HTTPS traffic configuration
  allow_https_request_in           = true
  allow_https_request_in_response  = true
  allow_https_request_out          = true
  allow_https_request_out_response = true
  
  # Enable flow logs for monitoring
  enable_flow_log = true
}
