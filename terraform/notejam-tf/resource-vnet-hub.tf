

# Get Resources from a Resource Group
data "azurerm_resource_group" "hub_rg" {
  name = var.vnet-hub["vnet_resourcegroup"]

  depends_on = [azurerm_resource_group.rg_hub]
}


resource "azurerm_network_security_group" "hub_nsg" {
  name                = "hubSecurityGroup"
  location            = data.azurerm_resource_group.hub_rg.location
  resource_group_name = data.azurerm_resource_group.hub_rg.name
  tags = {
    environment = "nordcloud notejam test"
  }
}


resource "azurerm_virtual_network" "hub_vnet" {
  name                = "hubVirtualNetwork"
  location            = data.azurerm_resource_group.hub_rg.location
  resource_group_name = data.azurerm_resource_group.hub_rg.name
  address_space       = ["10.0.0.0/22"]
  #dns_servers         = ["10.0.0.4", "10.0.0.5"]
  depends_on = [azurerm_network_ddos_protection_plan.notejamprotect]

  //Working code but commended due to cost
  /*ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.notejamprotect.id
    enable = true
  }*/

  subnet {
    name           = "hub_subnet_fwall"
    address_prefix = "10.0.0.0/24"
  }

  subnet {
    name           = "hub_bastian"
    address_prefix = "10.0.1.0/24"
  }

  tags = {
    environment = "nordcloud notejam test"
  }
}