
location      = "East US"
client_id     = "80684b5b-8d63-4191-bb79-76ebe0a08f84"
client_secret = "PUD8cvslf-jRUeNAQ9p_mHvSsxz5465k5_"
//Spoke
cluster = {
  app_name                     = "aks-notejam"
  app_resourcegroup            = "rg-app"
  dns_prefix                   = "nj"
  log_analytics_workspace_name = "ws-notejam"
}
//Hub
vnet-hub = {
  vnet_resourcegroup = "rg-hub-network"
}

//DB
db_server_name         = "nordcloud-mysqlserver"
database_name          = "dbnotejam"
db_resource_group_name = "rg-notejam-db"


administrator_login          = "mysqladminun"
administrator_login_password = "H@Sh1CoR3!"

sku_name   = "B_Gen5_2"
storage_mb = 5120
db_version = "5.7"



dbproperties = {
  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"


}
