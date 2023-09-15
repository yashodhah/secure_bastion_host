output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "database_subnet_group_name" {
  value       = module.vpc.name
  description = <<EOF
    The vpc subnet group name is not exposed by VPC module, but it's the same as the VPC Name.
  EOF

  depends_on = [
    module.vpc.database_subnet_group
  ]
}