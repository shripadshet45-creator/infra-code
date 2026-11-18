variable "subscription_id" {
  description = "Azure subscription ID where the infrastructure will be created"
  type        = string
}

variable "use_oidc" {
  description = "Use OIDC authentication for the AzureRM provider"
  type        = bool
  default     = true
}

variable "location" {
  description = "Azure region for the resource group and regional resources"
  type        = string
  default     = "centralindia"
}

variable "prefix" {
  description = "Common resource-name prefix"
  type        = string
  default     = "aks-learning"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,30}$", var.prefix))
    error_message = "prefix must contain 3-30 lowercase letters, numbers, or hyphens."
  }
}

variable "tags" {
  description = "Tags applied to Azure resources"
  type        = map(string)
  default = {
    project = "aks-learning"
    owner   = "shripad"
  }
}

variable "vnet_address_space" {
  description = "Address space for the AKS virtual network"
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "aks_nodes_subnet_prefix" {
  description = "Subnet prefix used by AKS system and user node pools"
  type        = string
  default     = "10.10.0.0/22"
}

variable "acr_name" {
  description = "Globally unique Azure Container Registry name"
  type        = string
  default     = "acrakslearningshripad"

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{5,50}$", var.acr_name))
    error_message = "acr_name must contain 5-50 alphanumeric characters and no hyphens."
  }
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version; null uses Azure's default supported version"
  type        = string
  default     = null
}

variable "system_node_vm_size" {
  description = "VM size for the system node pool"
  type        = string
  default     = "Standard_B2s"
}

variable "user_node_vm_size" {
  description = "VM size for the user node pool"
  type        = string
  default     = "Standard_B2ms"
}


