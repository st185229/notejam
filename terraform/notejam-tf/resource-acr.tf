//NodeJam container registry
resource "azurerm_container_registry" "acr-nodejan" {
  name                = var.nodejan_acr["name"]
  resource_group_name = var.nodejan_acr["resource_group_name"]
  location            = var.location
  sku                 = var.nodejan_acr["sku"]
  admin_enabled       = var.nodejan_acr_admin_enabled
  tags = {
    environment = "nordcloud"
  }

}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "acr-nodejan" {
  scope                = azurerm_container_registry.acr-nodejan.id
  role_definition_name = "AcrPull"
  principal_id         = module.app-cluster.principal_id
}

