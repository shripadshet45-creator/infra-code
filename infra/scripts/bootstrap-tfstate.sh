#!/usr/bin/env bash
set -euo pipefail

subscription_id="${1:?Usage: $0 <subscription-id>}"
location="${2:-eastus}"
resource_group="rg-tfstate"
storage_account="${3:-remotestate${RANDOM}}"
container="tfstate"

az account set --subscription "$subscription_id"
az group create --name "$resource_group" --location "$location"
az storage account create --name "$storage_account" --resource-group "$resource_group" --location "$location" --sku Standard_LRS --allow-blob-public-access false
account_key=$(az storage account keys list --account-name "$storage_account" --resource-group "$resource_group" --query '[0].value' --output tsv)
az storage container create --name "$container" --account-name "$storage_account" --account-key "$account_key"

echo "resource_group_name=$resource_group"
echo "storage_account_name=$storage_account"
echo "container_name=$container"
