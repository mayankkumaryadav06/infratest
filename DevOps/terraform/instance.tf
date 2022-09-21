module "instance" {
  source           = "./modules/instance"
  network_details  = local.instance_network_details
  instance_details = local.instance_details
  common_details = local.common_details
}
