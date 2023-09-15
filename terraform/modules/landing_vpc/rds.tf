locals {
  name = "test-db"
}

module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "8.3.1"

  name            = local.name
  engine          = "aurora-mysql"
  engine_version  = "8.0"
  master_username = "root"
  instances       = {
    1 = {
      instance_class = "db.t4g.large"
    }
  }

  vpc_id               = module.main_vpc.vpc_id
  db_subnet_group_name = module.main_vpc.database_subnet_group_name
  security_group_rules = {
    vpc_ingress = {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      source_security_group_id = module.ec2_bastion_sec_group.security_group_id
    }
  }

  apply_immediately   = true
  skip_final_snapshot = true

  create_db_cluster_parameter_group      = true
  db_cluster_parameter_group_name        = local.name
  db_cluster_parameter_group_family      = "aurora-mysql8.0"
  db_cluster_parameter_group_description = "${local.name} example cluster parameter group"
  db_cluster_parameter_group_parameters  = [
    {
      name         = "connect_timeout"
      value        = 120
      apply_method = "immediate"
    }, {
      name         = "innodb_lock_wait_timeout"
      value        = 300
      apply_method = "immediate"
    }, {
      name         = "log_output"
      value        = "FILE"
      apply_method = "immediate"
    }, {
      name         = "max_allowed_packet"
      value        = "67108864"
      apply_method = "immediate"
    }, {
      name         = "aurora_parallel_query"
      value        = "OFF"
      apply_method = "pending-reboot"
    }, {
      name         = "binlog_format"
      value        = "ROW"
      apply_method = "pending-reboot"
    }, {
      name         = "log_bin_trust_function_creators"
      value        = 1
      apply_method = "immediate"
    }, {
      name         = "require_secure_transport"
      value        = "ON"
      apply_method = "immediate"
    }, {
      name         = "tls_version"
      value        = "TLSv1.2"
      apply_method = "pending-reboot"
    }
  ]

  create_db_parameter_group      = true
  db_parameter_group_name        = local.name
  db_parameter_group_family      = "aurora-mysql8.0"
  db_parameter_group_description = "${local.name} example DB parameter group"
  db_parameter_group_parameters  = [
    {
      name         = "connect_timeout"
      value        = 60
      apply_method = "immediate"
    }, {
      name         = "general_log"
      value        = 0
      apply_method = "immediate"
    }, {
      name         = "innodb_lock_wait_timeout"
      value        = 300
      apply_method = "immediate"
    }, {
      name         = "log_output"
      value        = "FILE"
      apply_method = "pending-reboot"
    }, {
      name         = "long_query_time"
      value        = 5
      apply_method = "immediate"
    }, {
      name         = "max_connections"
      value        = 2000
      apply_method = "immediate"
    }, {
      name         = "slow_query_log"
      value        = 1
      apply_method = "immediate"
    }, {
      name         = "log_bin_trust_function_creators"
      value        = 1
      apply_method = "immediate"
    }
  ]

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags = var.tags
}