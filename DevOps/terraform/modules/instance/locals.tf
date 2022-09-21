locals {
  frontend_sg_name     = "${var.common_details.resource_prefix}-sg"
  resource_prefix      = var.common_details.resource_prefix
  vpc_id               = var.network_details.vpc_id
  subnet_id            = var.network_details.subnet_id
  azs_available        = var.network_details.azs_available
  instance_ami         = var.instance_details.instance_ami
  instance_type        = var.instance_details.instance_type
  instance_asg_max     = var.instance_details.instance_asg_max
  instance_asg_min     = var.instance_details.instance_asg_min
  instance_asg_desired = var.instance_details.instance_asg_desired
  frontend_app_port    = var.instance_details.frontend_app_port
}
