terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "remotestate1"
    container_name       = "tfstate"
    key                  = "dev/centralindia.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
}