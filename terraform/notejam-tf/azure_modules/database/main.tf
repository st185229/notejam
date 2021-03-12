//Suresh Thomas suresh.thomas@yahoo.com
resource "azurerm_mysql_database" "db" {
  name                = var.database_name
  resource_group_name = var.db_resource_group_name
  server_name         = var.db_server_name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}