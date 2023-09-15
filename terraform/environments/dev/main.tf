module "dev_infrastructure" {
  source      = "../../modules/landing_vpc"
  environment = local.environment

  main_vpc_cidr              = var.core_main_vpc_cidr
  main_vpc_az_count_private  = var.core_main_vpc_az_count_private
  main_vpc_az_count_database = var.core_main_vpc_az_count_database
  main_vpc_az_count_public   = var.core_main_vpc_az_count_public

  main_vpc_enable_nat_gateway       = var.core_main_vpc_enable_nat_gateway
  main_vpc_single_nat_gateway       = var.core_main_vpc_single_nat_gateway
  create_database_nat_gateway_route = var.create_database_nat_gateway_route

  tags = local.tags
}