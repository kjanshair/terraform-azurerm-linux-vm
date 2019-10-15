# Create public IPs
resource "azurerm_public_ip" "azure_vm_public_ip" {
    name                         = format("%s%s",var.vm_name,"-public-ip")
    location                     = var.location
    resource_group_name          = var.resource_group
    allocation_method            = "Static"
}

# Create network interface
resource "azurerm_network_interface" "azure_vm_network_interface_card" {
    name                      = format("%s%s",var.vm_name,"-nic")
    location                  = var.location
    resource_group_name       = var.resource_group
    network_security_group_id = var.vm_nsg_id

    ip_configuration {
        name                          = format("%s%s",var.vm_name,"-ipConf")
        subnet_id                     = var.vm_subnet_id
        private_ip_address_allocation = "dynamic"
        public_ip_address_id          = azurerm_public_ip.azure_vm_public_ip.id
    }
}

# Create virtual machine
resource "azurerm_virtual_machine" "azure_virtual_machine" {
    name                  = var.vm_name
    location              = var.location
    resource_group_name   = var.resource_group
    network_interface_ids = [azurerm_network_interface.azure_vm_network_interface_card.id]
    vm_size               = var.vm_size

    storage_os_disk {
        name              = format("%s%s",var.vm_name,"-OSDisk")
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = var.vm_os_publisher
        offer     = var.vm_offer
        sku       = var.vm_sku
        version   = "latest"
    }

    os_profile {
        computer_name  = format("%s%s",var.vm_name,"-vm")
        admin_username = var.vm_user
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = format("/home/%s/.ssh/authorized_keys",var.vm_user)
            key_data = file(var.vm_ssh_key_path)
        }
    }
}