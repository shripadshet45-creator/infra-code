variable "location" {
  description = "Azure region"
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "rg-dev-centralindia"
}

variable "vm_count" {
  description = "Number of VMs"
  type        = number
  default     = 5
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_B2s_v2"
}

variable "admin_username" {
  description = "VM admin username"
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.11.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Subnet CIDR"
  type        = list(string)
  default     = ["10.11.1.0/24"]
}

variable "allowed_admin_cidrs" {
  description = "Allowed admin CIDRs"
  type        = list(string)
  default     = ["203.0.113.10/32"]
}

variable "allowed_inbound_ports" {
  description = "Allowed inbound ports"
  type        = list(number)
  default     = [22]
}
