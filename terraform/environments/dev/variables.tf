variable "environment" {}
variable "aws_region_main" {}

variable "core_main_vpc_cidr" { default = "" }
variable "core_main_vpc_az_count_private" { default = 2 }
variable "core_main_vpc_az_count_database" { default = 2 }
variable "core_main_vpc_az_count_public" { default = 2 }

variable "core_main_vpc_enable_nat_gateway" { default = true }
variable "core_main_vpc_single_nat_gateway" { default = true }
variable "create_database_nat_gateway_route" { default = false }

variable "project_name" { default = "dev-infrastructure" }

