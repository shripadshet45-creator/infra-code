output "resource_group_name" {
  description = "Azure resource group name"
  value       = azurerm_resource_group.aks.name
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "acr_login_server" {
  description = "Container registry login server"
  value       = azurerm_container_registry.acr.login_server
}

output "kube_config" {
  description = "Raw Kubernetes configuration"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}
