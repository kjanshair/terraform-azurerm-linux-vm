###############################################
# OUTPUT
###############################################

output "public_ip_address" {
  value = azurerm_public_ip.azure_vm_public_ip.ip_address
  description = "Public IP address to connect to the VM"
}

output "private_ip_address" {
  value = azurerm_network_interface.azure_vm_network_interface_card.private_ip_address
  description = "Private IP address of the VM"
}
