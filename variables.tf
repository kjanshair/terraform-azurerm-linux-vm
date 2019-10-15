variable "resource_group" {
  type    = string
  description = "Resource Group"
}

variable "location" {
  type    = string
  description = "Resource Group"
}

variable "vm_subnet_id" {
  type    = string
  description = "Subnet ID"
}

variable "vm_nsg_id" {
  type    = string
  description = "Network Security Group ID"
}

variable "vm_offer" {
  type    = string
  default = "UbuntuServer"
  description = "VM Image Offer"
}

variable "vm_sku" {
  type    = string
  default = "16.04.0-LTS"
  description = "VM Image SKU"
}


variable "vm_os_publisher" {
  type    = string
  default = "Canonical"
  description = "VM Image Publisher"
}

variable "vm_size" {
  type    = string
  default = "Standard_DS1_v2"
  description = "VM Size"
}

variable "vm_name" {
  type    = string
  default = "default"
  description = "Name for the VM"
}

variable "vm_user" {
  type    = string
  default = "ubuntu"
  description = "Linux user"
}

variable "vm_ssh_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
  description = "Path to public SSH key"
}



