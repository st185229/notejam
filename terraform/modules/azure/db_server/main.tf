//Suresh Thomas suresh.thomas@yahoo.com
resource "azurerm_resource_group" "rg_db" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_mysql_server" "mysqlserver" {
  name                = var.db_server_name
  location            = azurerm_resource_group.rg_db.location
  resource_group_name = azurerm_resource_group.rg_db.name

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  sku_name   = var.sku_name
  storage_mb = var.storage_mb
  version    = var.db_version

  auto_grow_enabled                 = var.dbproperties["auto_grow_enabled"]
  backup_retention_days             = var.dbproperties["backup_retention_days"]
  geo_redundant_backup_enabled      = var.dbproperties["geo_redundant_backup_enabled"]
  infrastructure_encryption_enabled = var.dbproperties["infrastructure_encryption_enabled"]
  public_network_access_enabled     = var.dbproperties["public_network_access_enabled"]
  ssl_enforcement_enabled           = var.dbproperties["ssl_enforcement_enabled"]
  ssl_minimal_tls_version_enforced  = var.dbproperties["ssl_minimal_tls_version_enforced"]
}