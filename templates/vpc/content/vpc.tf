#
# VPC
#

module "vpc" {
  source                            = "github.com/cds-snc/terraform-modules//vpc?ref=v9.2.5"
  name                              = ${{ values.vpc_name | dump }}
  billing_tag_value                 = ${{ values.billing_tag_value| dump }} 
  availability_zones                = ${{ values.availability_zones | dump }}
  single_nat_gateway                = ${{ values.single_nat_gateway }}
  allow_https_requests_in           = ${{ values.allow_https_requests_in | dump }}
  allow_https_requests_in_response  = ${{ values.allow_https_requests_in_response }}
  allow_https_requests_out          = ${{ values.allow_https_requests_out | dump }}
  allow_https_requests_out_response = ${{ values.allow_https_requests_out_response }}

  resource "aws_flow_log" "cloud_based_sensor" {
    count                =  ${{ values.cloud_based_sensor }} 
    log_destination      = "arn:aws:s3:::cbs-satellite-${{ values.account_id }}/vpc_flow_logs/"
    log_destination_type = "s3"
    traffic_type         = "ALL"
    vpc_id               = module.vpc.vpc_id
    log_format           = "$${vpc-id} $${version} $${account-id} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${action} $${log-status} $${subnet-id} $${instance-id}"
    tags = {
      CostCentre = ${{ values.billing_tag_value | dump }}
      Terraform  = true
    }
  }
}