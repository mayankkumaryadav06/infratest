locals {
  db_engine              = var.db_details.db_engine
  instance_class         = var.db_details.db_instance_class
  multi_az               = var.db_details.db_multi_az
  db_admin_username      = var.db_details.db_admin_username
  password               = var.db_details.db_admin_password
  allocated_storage      = var.db_details.db_allocated_storage
  vpc_security_group_ids = [var.db_network_details.db_inbound_sg.id]
  subnet_ids             = var.db_network_details.db_private_subnet
  db_subnet_group_name   = "${var.common_details.client}-${var.common_details.environment}-db-subnet-group"
  db_admin_password      = length(try(var.db_details.db_admin_password, "")) > 0 ? var.db_details.db_admin_password : random_password.password.result
  db_engine_version      = length(try(var.db_details.db_engine_version, "")) > 0 ? var.db_details.db_engine_version : data.aws_rds_engine_version.test.version
  db_instance_name       = length(try(var.db_details.db_instance_name, "")) > 0 ? var.db_details.db_instance_name : "${var.common_details.client}-${var.common_details.environment}-db"
  db_name                = length(try(var.db_details.db_name, "")) > 0 ? var.db_details.db_name : "${var.common_details.client}${var.common_details.environment}db"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

data "aws_rds_engine_version" "test" {
  engine = var.db_details.db_engine
}

output "db_name" {
  value = local.db_instance_name
}
