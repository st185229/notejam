

# Get Resources from a Resource Group
data "azurerm_resource_group" "app_rg" {
  name       = var.cluster["app_resourcegroup"]
  depends_on = [azurerm_resource_group.rg_spoke]
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = "appSecurityGroup"
  location            = data.azurerm_resource_group.app_rg.location
  resource_group_name = data.azurerm_resource_group.app_rg.name
  tags = {
    environment = "nordcloud notejam test"
  }
}
resource "azurerm_virtual_network" "app_vnet" {
  name                = "spokeVirtualNetwork"
  location            = data.azurerm_resource_group.app_rg.location
  resource_group_name = data.azurerm_resource_group.app_rg.name
  address_space       = ["10.0.4.0/22"]
  #dns_servers         = ["10.0.0.4", "10.0.0.5"]
  #depends_on = [azurerm_network_ddos_protection_plan.notejamprotect]

  #Working code but commended due to cost

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.notejamprotect.id
    enable = true
  }

  subnet {
    name           = "ingress_subnet"
    address_prefix = "10.0.4.0/24"
  }

  subnet {
    name           = "kube_node_subnet"
    address_prefix = "10.0.5.0/24"
  }

  tags = {
    environment = "nordcloud notejam test"
  }

}