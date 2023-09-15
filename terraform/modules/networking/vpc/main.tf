locals {
  subnets = cidrsubnets(var.vpc_cidr, [2, 2, 2, 4, 4, 4, 6, 6, 6]...)

  private_subnets  = coalesce(var.private_subnets, slice(slice(local.subnets, 0, 3), 0, length(var.azs_private)))
  database_subnets = coalesce(var.database_subnets, slice(slice(local.subnets, 3, 6), 0, length(var.azs_database)))
  public_subnets   = coalesce(var.public_subnets, slice(slice(local.subnets, 6, 9), 0, length(var.azs_public)))

  azs = distinct(concat(var.azs_private, var.azs_database, var.azs_public))

  max_subnet_length = max(
    length(local.private_subnets),
    length(local.database_subnets),
  )
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  create_vpc = var.enabled

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs  = local.azs

  # Subnets configuration
  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  database_subnets = local.database_subnets

  # Route Tables configuration
  create_database_subnet_route_table = true

  # NATs configuration
  enable_nat_gateway                = var.vpc_enable_nat_gateway
  single_nat_gateway                = var.vpc_single_nat_gateway
  create_database_nat_gateway_route = var.create_database_nat_gateway_route

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}
