module "database" {
  source             = "./modules/database"
  common_details     = local.common_details
  db_network_details = local.db_network_details
  db_details         = local.db_details
}
