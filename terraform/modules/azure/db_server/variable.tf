//Created by Suresh


variable resource_group_name{
    type =string
}

variable location{
    type =string
}

variable db_server_name{
    type =string
}

variable administrator_login  {
    type =string
    default        = "mysqladminun"
}

variable administrator_login_password{
    type =string
    default = "nordcloud"
}

variable sku_name {
    type =string
}

variable storage_mb {
    type = number
    default = 5120
}

variable db_version{
    type =string
    default= 5.7
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
