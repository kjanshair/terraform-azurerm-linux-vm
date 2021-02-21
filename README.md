## Stand-Alone Linux VM with Azure

This module provisions a stand-alone Linux VM and uses Terraform 0.12+.

```
resource "azurerm_resource_group" "azure_resource_group" {
  name     = "default"
  location = "southeastasia"
}

module "azure_virtual_network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  location            = azurerm_resource_group.azure_resource_group.location
  vnet_name           = var.vnet_name
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet-1", "subnet-2", "subnet-3"]

  tags = {
    environment = "azure-linux"
  }
}

module "network_security_group" {
  source              = "Azure/network-security-group/azurerm"
  resource_group_name = azurerm_resource_group.azure_resource_group.name
  location            = azurerm_resource_group.azure_resource_group.location
  security_group_name = "Terraform-NSG"

  predefined_rules = [
    {
      name                  = "SSH"
      priority              = "1001"
      source_address_prefix = ["*"]
    },
    {
      name                  = "HTTP"
      priority              = "1002"
      source_address_prefix = ["*"]
    }
  ]
}

module "vm" {
  source       = "kjanshair/linux-vm/azurerm"
  resource_group = azurerm_resource_group.azure_resource_group.location
  location     = "southeastasia"
  vm_subnet_id = module.azure_virtual_network.vnet_subnets[0]
  vm_nsg_id    = module.network_security_group.network_security_group_id
  vm_user      = "ubuntu"
  vm_name      = "linux"
  vm_ssh_key_path = "~/.ssh/id_rsa.pub"
}
```

This module does not use Azure Storage Account for Boot Diagnostics and uses standard storage options for OS disk as show below:

```
caching           = "ReadWrite"
create_option     = "FromImage"
managed_disk_type = "Premium_LRS"
```
