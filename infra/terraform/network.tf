resource "azurerm_virtual_network" "aks" {
  name                = "vnet-${var.prefix}"                # -> vnet-aks-learning
  location            = azurerm_resource_group.aks.location # same region as the RG
  resource_group_name = azurerm_resource_group.aks.name     # put it INSIDE rg-aks-learning
  address_space       = var.vnet_address_space              # -> 10.10.0.0/16
  tags                = var.tags
}

resource "azurerm_subnet" "aks_nodes" {
  name                 = "snet-aks-nodes"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name # put it INSIDE the VNet
  address_prefixes     = [var.aks_nodes_subnet_prefix]    # -> 10.10.0.0/22
}