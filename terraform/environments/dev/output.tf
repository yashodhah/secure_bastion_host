output "bastion_instance_id" {
  description = "List of IDs of public subnets"
  value       = module.dev_infrastructure.bastion_instance_id
}

output "database_endpoint" {
  description = "DB instance endpoint"
  value       = module.dev_infrastructure.cluster_endpoint
}