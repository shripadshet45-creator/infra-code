
resource "azurerm_log_analytics_workspace" "aks" {
  name                = "log-${var.prefix}" # -> log-aks-learning
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  sku                 = "PerGB2018" # pay per GB of logs
  retention_in_days   = 30          # keep logs 30 days
  tags                = var.tags
}