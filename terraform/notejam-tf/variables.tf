
variable "location" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
# Variables related to application deployment cluster 
variable "cluster" {
  type = map
  default = {
    app_name                     = "aks-notejam"
    app_resourcegroup            = "rg-app"
    dns_prefix                   = "nj"
    log_analytics_workspace_name = "ws-notejam"
  }
}
variable "vnet-hub" {
  type = map
  default = {
    vnet_resourcegroup = "rg-hub-network"

  }
}


variable db_server_name {
  type = string
}

variable database_name {
  type = string
}


variable administrator_login {
  type = string
}

variable administrator_login_password {
  type = string

}
variable db_resource_group_name {
  type    = string
  default = "rg-notejam-db"
}



variable sku_name {
  type = string
}

variable storage_mb {
  type    = number
  default = 5120
}

variable db_version {
  type    = string
  default = 5.7
}



variable "dbproperties" {
  type = map
  default = {
    auto_grow_enabled                 = true
    backup_retention_days             = 7
    geo_redundant_backup_enabled      = false
    infrastructure_encryption_enabled = false
    public_network_access_enabled     = true
    ssl_enforcement_enabled           = true
    ssl_minimal_tls_version_enforced  = "TLS1_2"

  }
}




