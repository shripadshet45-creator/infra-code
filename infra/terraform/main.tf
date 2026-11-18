resource "azurerm_resource_group" "aks" {
  name     = "rg-${var.prefix}" # -> rg-aks-learning
  location = var.location       # -> centralindia
  tags     = var.tags           # -> project = aks-learning, owner = shripad
}