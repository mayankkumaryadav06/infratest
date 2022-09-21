
resource "aws_db_instance" "this" {
  allocated_storage      = local.allocated_storage
  engine                 = local.db_engine
  instance_class         = local.instance_class
  multi_az               = local.multi_az
  identifier             = local.db_instance_name
  db_name                = local.db_name
  username               = local.db_admin_username
  vpc_security_group_ids = local.vpc_security_group_ids
  password               = local.db_admin_password
  engine_version         = local.db_engine_version
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.this.name
}

resource "aws_db_subnet_group" "this" {
  name       = local.db_subnet_group_name
  subnet_ids = local.subnet_ids

  tags = {
    Name = "Terraform managed DB Subnet Group"
  }
}