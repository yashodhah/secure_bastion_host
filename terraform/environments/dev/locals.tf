locals {
  environment = "${var.environment}-${terraform.workspace}"
  tags = {
    environment = local.environment
    workspace   = terraform.workspace
    project     = var.project_name
  }
}