location        = "centralindia"
prefix          = "aks-learning"

vnet_address_space      = ["10.10.0.0/16"]
aks_nodes_subnet_prefix = "10.10.0.0/22"

acr_name            = "acrakslearningshripad"
kubernetes_version  = null
system_node_vm_size = "Standard_B2s"
user_node_vm_size   = "Standard_B2ms"

tags = {
  project = "aks-learning"
  owner   = "shripad"
}

