data "azurerm_virtual_network" "hub_vnet" {
  name                = "hubVirtualNetwork"
  resource_group_name = data.azurerm_resource_group.hub_rg.name
  depends_on          = [azurerm_virtual_network.hub_vnet]

}
data "azurerm_virtual_network" "app_vnet" {
  name                = "spokeVirtualNetwork"
  resource_group_name = data.azurerm_resource_group.app_rg.name
  depends_on          = [azurerm_virtual_network.app_vnet]
}
resource "azurerm_virtual_network_peering" "HubToSpoke1" {
  name                      = "peerHtoS"
  resource_group_name       = var.vnet-hub["vnet_resourcegroup"]
  virtual_network_name      = data.azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.app_vnet.id

}
resource "azurerm_virtual_network_peering" "Spoke1ToHub" {
  name                      = "peerStoH"
  resource_group_name       = var.cluster["app_resourcegroup"]
  virtual_network_name      = data.azurerm_virtual_network.app_vnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.hub_vnet.id
}
