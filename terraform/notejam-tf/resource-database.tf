//Suresh Thomas suresh.thomas@yahoo.com
module "app-db" {
  source                 = "./azure_modules/database"
  database_name          = var.database_name
  db_resource_group_name = var.db_resource_group_name
  db_server_name         = var.db_server_name
  depends_on             = [module.app-datbase-server]
}