locals {
  resource_prefix      = "${var.client}-${var.environment}"
  public_subnet_cidrs  = format("%s,%s,%s", cidrsubnet(var.vpc_cidr, 6, 0), cidrsubnet(var.vpc_cidr, 6, 2), cidrsubnet(var.vpc_cidr, 6, 3))
  private_subnet_cidrs = format("%s,%s,%s", cidrsubnet(var.vpc_cidr, 6, 4), cidrsubnet(var.vpc_cidr, 6, 5), cidrsubnet(var.vpc_cidr, 6, 6))
  azs_available        = slice(data.aws_availability_zones.available.names, 0, length(data.aws_availability_zones.available.names))
  instance_ami         = "ami-0e34bbddc66def5ac"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr

  common_details = {
    region          = var.region      # "Region of cluster deployment"
    environment     = var.environment # "Environment for which deployment is happening"
    client          = var.client      # "Client for which deployment is happening
    resource_prefix = local.resource_prefix
  }

  db_network_details = {
    db_private_subnet = module.network.private_subnet
    db_inbound_sg     = module.instance.frontend_instance_sg
  }

  db_details = {
    db_allocated_storage = var.db_allocated_storage
    db_engine            = var.db_engine
    db_instance_class    = var.db_instance_class
    db_multi_az          = var.db_multi_az
    db_name              = var.db_name
    db_instance_name     = var.db_instance_name
    db_admin_username    = var.db_admin_username
    db_admin_password    = var.db_admin_password
    db_engine_version    = var.db_engine_version
  }

  instance_network_details = {
    vpc_id        = module.network.vpc_id
    subnet_id     = module.network.public_subnet
    azs_available = slice(data.aws_availability_zones.available.names, 0, length(data.aws_availability_zones.available.names))
  }

  instance_details = {
    frontend_app_port    = var.frontend_app_port
    instance_type        = var.instance_type
    instance_ami         = local.instance_ami
    instance_asg_max     = var.instance_asg_max
    instance_asg_min     = var.instance_asg_min
    instance_asg_desired = var.instance_asg_desired
  }

}
