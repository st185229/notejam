//Suresh Thomas suresh.thomas@yahoo.com
module "app-cluster" {
  source                       = "../modules/azure/aks"
  location                     = var.location
  resource_group_name          = var.cluster["app_resourcegroup"]
  agent_count                  = 1
  dns_prefix                   = var.cluster["dns_prefix"]
  cluster_name                 = var.cluster["app_name"]
  log_analytics_workspace_name = var.cluster["log_analytics_workspace_name"]
  client_id                    = var.client_id
  client_secret                = var.client_secret
}