output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_name" {
  value = module.vpc.name
}

output "cidr_block" {
  value = module.vpc.cidr_block
}

output "public_ips" {
  value = module.vpc.public_ips
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "public_subnet_cidr_blocks" {
  value = module.vpc.public_subnet_cidr_blocks
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "private_subnet_cidr_blocks" {
  value = module.vpc.private_subnet_cidr_blocks
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "main_nacl_id" {
  value = module.vpc.main_nacl_id
}

output "main_route_table_id" {
  value = module.vpc.main_route_table_id
}