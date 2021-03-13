//Suresh Thomas suresh.thomas@yahoo.com
// General variables
variable "location" {
  type = string
}

variable "standby_location" {
  type = string
}


variable "client_id" {}
variable "client_secret" {}

# Variables related to application deployment cluster 
variable "cluster" {
  type = map(any)
  default = {
    app_name                     = "aks-notejam"
    app_resourcegroup            = "rg-app"
    dns_prefix                   = "nj"
    log_analytics_workspace_name = "ws-notejam"
  }
}
variable "vnet-hub" {
  type = map(any)
  default = {
    vnet_resourcegroup = "rg-hub-network"

  }
}
// These variables are related to DB
variable "db_server_name" {
  type = string
}
variable "database_name" {
  type = string
}
variable "administrator_login" {
  type = string
}
variable "administrator_login_password" {
  type = string
}
variable "db_resource_group_name" {
  type    = string
  default = "rg-notejam-db"
}
variable "sku_name" {
  type = string
}

variable "storage_mb" {
  type    = number
  default = 5120
}
variable "db_version" {
  type    = string
  default = 5.7
}
//SQl specific database 
variable "dbproperties" {
  type = map(any)
  default = {
    auto_grow_enabled                 = true
    backup_retention_days             = 7
    geo_redundant_backup_enabled      = false
    infrastructure_encryption_enabled = false
    public_network_access_enabled     = true
    ssl_enforcement_enabled           = false
    ssl_minimal_tls_version_enforced  = "TLS1_2"



  }
}
//Related to ACR
variable "nodejan_acr" {
  type = map(any)
  default = {
    name                = "acrnoedjam"
    resource_group_name = "rg-acr"
    sku                 = "Standard"

  }
}
variable "nodejan_acr_admin_enabled" {
  type    = bool
  default = false
}



 