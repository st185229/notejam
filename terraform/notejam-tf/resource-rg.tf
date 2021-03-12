// Hub is where Hub-networks stays


// Spoke is where AKS stays
resource "azurerm_resource_group" "rg_hub" {
  name     = var.vnet-hub["vnet_resourcegroup"]
  location = var.location
}



// Spoke is where AKS stays
resource "azurerm_resource_group" "rg_spoke" {
  name     = var.cluster["app_resourcegroup"]
  location = var.location
}
