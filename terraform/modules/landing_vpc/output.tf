output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.main_vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.main_vpc.private_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.main_vpc.database_subnets
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.main_vpc.vpc_id
}

output "bastion_instance_id" {
  description = "The instance ID of the bastion"
  value       = module.ec2_bastion.id
}

output "cluster_endpoint" {
  description = "DB cluster - Writer endpoint"
  value       = module.aurora.cluster_endpoint
}