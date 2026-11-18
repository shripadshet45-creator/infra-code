
terraform {
  backend "azurerm" {
    resource_group_name  = "<rg-of-remotestate1>"   # the RG where you created remotestate1
    storage_account_name = "remotestate1"
    container_name       = "remotestate"
    key                  = "aks-learning.tfstate"  # file name Terraform will create inside the container
    use_azuread_auth     = true                    # log in with your Azure identity, not storage keys
  }
}