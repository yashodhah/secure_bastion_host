variable "environment" {}

variable "main_vpc_az_count_private" {}
variable "main_vpc_az_count_database" {}
variable "main_vpc_az_count_public" {}

variable "main_vpc_cidr" {}
variable "main_vpc_public_subnets" { default = null }
variable "main_vpc_private_subnets" { default = null }
variable "main_vpc_database_subnets" { default = null }

variable "main_vpc_enable_nat_gateway" { default = false }
variable "main_vpc_enable_nat_instance" { default = false }
variable "main_vpc_single_nat_gateway" { default = false }
variable "main_vpc_one_nat_gateway_per_az" { default = false }
variable "create_database_nat_gateway_route" { default = false }

variable "tags" { type = map(string) }



