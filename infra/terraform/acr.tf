resource "azurerm_container_registry" "acr" {
  name                = var.acr_name # -> acrakslearningshripad
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  sku                 = "Basic" # cheapest tier
  admin_enabled       = false   # no username/password login
  tags                = var.tags
}