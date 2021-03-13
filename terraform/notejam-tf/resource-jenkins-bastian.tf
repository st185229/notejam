
//Take from hub resource group
data "azurerm_resource_group" "rg_hub" {
  name       = var.vnet-hub["vnet_resourcegroup"]
  depends_on = [azurerm_resource_group.rg_hub]

}

# refer hub vnet

/*data  "azurerm_virtual_network" "hub_vnet" {
   name                = "hubVirtualNetwork"
   depends_on = [azurerm_resource_group.rg_hub]
}*/

# refer bastin-jenkins subnet
data "azurerm_subnet" "bastian-subnet" {
  name                 = "hub_bastian"
  virtual_network_name = data.azurerm_virtual_network.hub_vnet.name
  resource_group_name  = data.azurerm_resource_group.rg_hub.name
  depends_on           = [azurerm_virtual_network.hub_vnet]
}


# Create public IPs
resource "azurerm_public_ip" "bastian_public_ip" {
  name                = "bastianPubIP"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_hub.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "nordcloud notejam test"
  }
}

# Create network interface
resource "azurerm_network_interface" "bastian_nic" {
  name                = "bastianNIC"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_hub.name

  ip_configuration {
    name                          = "bastianNICConfiguration"
    subnet_id                     = data.azurerm_subnet.bastian-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastian_public_ip.id
  }

  tags = {
    environment = "nordcloud notejam test"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg_associate" {
  network_interface_id      = azurerm_network_interface.bastian_nic.id
  network_security_group_id = azurerm_network_security_group.ssh-80-8080.id
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = data.azurerm_resource_group.rg_hub.name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "nordcloudstorageaccount" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = data.azurerm_resource_group.rg_hub.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "nordcloud notejam test"
  }
}

# Create (and display) an SSH key
resource "tls_private_key" "bastian_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
output "tls_private_key" { value = tls_private_key.bastian_ssh.private_key_pem }

# Create virtual machine
resource "azurerm_linux_virtual_machine" "bastian_jenkins_vm" {
  name                  = "bastjenknc"
  location              = var.location
  resource_group_name   = data.azurerm_resource_group.rg_hub.name
  network_interface_ids = [azurerm_network_interface.bastian_nic.id]
  size                  = "Standard_A2_v2"


  #custom_data = ${filebase64(${file("cloud-init-jenkins.txt")})

  custom_data = filebase64("cloud-init-jenkins.txt")


  os_disk {
    name                 = "norddisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "bastjenknc"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.bastian_ssh.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.nordcloudstorageaccount.primary_blob_endpoint
  }

  tags = {
    environment = "nordcloud notejam test"
  }
}