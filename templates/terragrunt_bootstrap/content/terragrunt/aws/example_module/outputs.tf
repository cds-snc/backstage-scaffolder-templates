# Output file containing outputs that were generated by the terraform module. Those outputs can be used by other terraform modules or by the user to get information about the resources created by the module.
#
# The file has the following structure:
#
# output "output_name" {
#    description = "A description of what the output variable is."
#    value       = the value of the resource (for example arn, id, name, etc)
#  }
#
# An example is the following:
#
# output "vpc_id" {
#    description = "The id of the VPC"
#    value       = module.vpc_name.vpc_id
#  }