//Suresh Thomas suresh.thomas@yahoo.com
resource "azurerm_resource_group" "k8s" {
    name     = var.resource_group_name
    location = var.location
}
resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}
resource "azurerm_log_analytics_workspace" "notejam" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
    location            = var.log_analytics_workspace_location
    resource_group_name = azurerm_resource_group.k8s.name
    sku                 = var.log_analytics_workspace_sku
}
//Log analytics
resource "azurerm_log_analytics_solution" "notejam" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.notejam.location
    resource_group_name   = azurerm_resource_group.k8s.name
    workspace_resource_id = azurerm_log_analytics_workspace.notejam.id
    workspace_name        = azurerm_log_analytics_workspace.notejam.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}
//app
resource "azuread_application" "aks_sp" {
  display_name = "sp-aks-${var.cluster_name}"
}
//Service principle
resource "azuread_service_principal" "aks_sp" {
  application_id               = azuread_application.aks_sp.application_id
  app_role_assignment_required = false
}
resource "azuread_service_principal_password" "aks_sp" {
  service_principal_id = azuread_service_principal.aks_sp.id
  value                = random_string.aks_sp_password.result
  end_date_relative    = "8760h" # 1 year

  lifecycle {
    ignore_changes = [
      value,
      end_date_relative
    ]
  }
}
resource "random_string" "aks_sp_password" {
  keepers = {
    env_name = "sp-aks-${var.cluster_name}"
  }
  length           = 24
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  special          = true
  min_special      = 1
  override_special = "!@-_=+."
}
resource "azurerm_kubernetes_cluster" "k8s" {
    name                = var.cluster_name
    location            = azurerm_resource_group.k8s.location
    resource_group_name = azurerm_resource_group.k8s.name
    dns_prefix          = var.dns_prefix

    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }

    default_node_pool {
        name            = "agentpool"
        node_count      = var.agent_count
        vm_size         = "Standard_D2_v2"
    }

     service_principal {
         client_id     = azuread_service_principal.aks_sp.application_id
         client_secret = random_string.aks_sp_password.result
  }

    addon_profile {
        oms_agent {
        enabled                    = true
        log_analytics_workspace_id = azurerm_log_analytics_workspace.notejam.id
        }
    }

    network_profile {
    load_balancer_sku = "Standard"
    network_plugin = "kubenet"
    }

    tags = {
        Environment = "Development"
    }
}