terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "<globally_unique_storage_account_name>"
    container_name       = "tfstate"
    key                  = "aks-learning.tfstate"
    use_azuread_auth     = true
  }
}