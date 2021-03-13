resource "azurerm_network_ddos_protection_plan" "notejamprotect" {
  name                = "nordddosprotect"
  location            = data.azurerm_resource_group.app_rg.location
  resource_group_name = data.azurerm_resource_group.app_rg.name
  tags = {
    environment = "nordcloud notejam test"
  }
}

 