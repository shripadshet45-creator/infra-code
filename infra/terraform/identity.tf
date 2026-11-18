# ---------- The 2 identities ----------
resource "azurerm_user_assigned_identity" "aks_control_plane" {
  name                = "id-${var.prefix}-control-plane"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  tags                = var.tags
}

resource "azurerm_user_assigned_identity" "aks_kubelet" {
  name                = "id-${var.prefix}-kubelet"
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  tags                = var.tags
}

# ---------- The 3 roles ----------
# 1. Kubelet identity can PULL images from ACR
resource "azurerm_role_assignment" "kubelet_acr_pull" {
  principal_id         = azurerm_user_assigned_identity.aks_kubelet.principal_id # WHO
  role_definition_name = "AcrPull"                                               # WHICH permission
  scope                = azurerm_container_registry.acr.id                       # ON WHAT

  depends_on = [azurerm_container_registry.acr]
}

# 2. Control plane identity can manage the node subnet
resource "azurerm_role_assignment" "control_plane_subnet" {
  principal_id         = azurerm_user_assigned_identity.aks_control_plane.principal_id
  role_definition_name = "Network Contributor"
  scope                = azurerm_subnet.aks_nodes.id
}

# 3. Control plane identity can attach the kubelet identity to the node VMs
resource "azurerm_role_assignment" "control_plane_kubelet_operator" {
  principal_id         = azurerm_user_assigned_identity.aks_control_plane.principal_id
  role_definition_name = "Managed Identity Operator"
  scope                = azurerm_user_assigned_identity.aks_kubelet.id
}