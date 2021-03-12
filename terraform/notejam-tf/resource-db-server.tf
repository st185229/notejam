//Suresh Thomas suresh.thomas@yahoo.com
module "app-datbase-server" {
  source                       = "../modules/azure/db_server"
  db_server_name               = var.db_server_name
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  sku_name                     = var.sku_name
  storage_mb                   = var.storage_mb
  db_version                   = var.db_version
  resource_group_name          = var.db_resource_group_name
  location                     = var.location

  #public_network_access_enabled     = var.dbproperties["public_network_access_enabled"]
  # ssl_enforcement_enabled           = var.dbproperties["ssl_enforcement_enabled"]
  #ssl_minimal_tls_version_enforced  = var.dbproperties["ssl_minimal_tls_version_enforced"]
}

