# Create Network Security Group and rule
resource "azurerm_network_security_group" "ssh-80-8080" {
  name                = "bastian-jenkins-sg"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_hub.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "nordcloud notejam test"
  }
}

resource "azurerm_network_security_rule" "allow8080" {
  name                        = "HTTP_8080"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.rg_hub.name
  network_security_group_name = azurerm_network_security_group.ssh-80-8080.name
}
resource "azurerm_network_security_rule" "allow80" {
  name                        = "HTTP_80"
  priority                    = 1003
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.rg_hub.name
  network_security_group_name = azurerm_network_security_group.ssh-80-8080.name
}
