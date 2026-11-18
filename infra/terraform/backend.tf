terraform {
  backend "azurerm" {
    resource_group_name  = "<rg-of-remotestate1>"   # remotestate1 → Overview → Resource group
    storage_account_name = "remotestate1"
    container_name       = "remotestate"
    key                  = "aks-learning.tfstate"
    use_azuread_auth     = true
  }
}