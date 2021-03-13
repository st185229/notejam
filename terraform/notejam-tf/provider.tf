terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}

  subscription_id = "81432554-220c-405f-9b16-8c1ef66ecfe5"
  tenant_id       = "614a2ce2-e1f9-4ce4-824e-0ec9bd92cb65"
}
provider "azuread" {
}