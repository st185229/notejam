//Suresh Thomas suresh.thomas@yahoo.com
// Spoke is where AKS stays
resource "azurerm_resource_group" "rg_hub" {
  name     = var.vnet-hub["vnet_resourcegroup"]
  location = var.location
  tags = {
    environment = "nordcloud notejam test"
  }
}

// Spoke is where AKS stays
resource "azurerm_resource_group" "rg_spoke" {
  name     = var.cluster["app_resourcegroup"]
  location = var.location
  tags = {
    environment = "nordcloud notejam test"
  }
}

// Spoke is where AKS stays
resource "azurerm_resource_group" "rg_acr" {
  name     = var.nodejan_acr["resource_group_name"]
  location = var.location
  tags = {
    environment = "nordcloud notejam test"
  }
}
