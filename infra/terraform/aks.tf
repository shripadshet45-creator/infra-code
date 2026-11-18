resource "azurerm_kubernetes_cluster" "aks" {
  # ---------- 1. BASICS ----------
  name                = "aks-${var.prefix}" # -> aks-aks-learning
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.prefix               # used in the API server URL
  kubernetes_version  = var.kubernetes_version   # null = Azure's default version
  sku_tier            = "Free"                   # control plane free, no SLA
  node_resource_group = "rg-${var.prefix}-nodes" # 2nd RG that Azure manages

  automatic_upgrade_channel = "patch"     # auto 1.30.1 -> 1.30.2
  node_os_upgrade_channel   = "NodeImage" # auto OS security patches

  # ---------- 2. SYSTEM NODE POOL ----------
  default_node_pool {
    name                         = "system"
    vm_size                      = var.system_node_vm_size # Standard_B2s
    node_count                   = 1
    vnet_subnet_id               = azurerm_subnet.aks_nodes.id # nodes get IPs from OUR subnet
    os_disk_size_gb              = 64
    only_critical_addons_enabled = true # only system pods here
    temporary_name_for_rotation  = "systemtmp"

    upgrade_settings {
      max_surge = "10%"
    }
  }

  # ---------- 3. IDENTITIES (from identity.tf) ----------
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_control_plane.id]
  }

  kubelet_identity {
    client_id                 = azurerm_user_assigned_identity.aks_kubelet.client_id
    object_id                 = azurerm_user_assigned_identity.aks_kubelet.principal_id
    user_assigned_identity_id = azurerm_user_assigned_identity.aks_kubelet.id
  }

  # ---------- 4. NETWORKING ----------
  network_profile {
    network_plugin      = "azure" # Azure CNI
    network_plugin_mode = "overlay"
    network_data_plane  = "cilium"
    network_policy      = "cilium"
    pod_cidr            = "192.168.0.0/16" # pod IPs
    service_cidr        = "10.0.0.0/16"    # Service (ClusterIP) IPs
    dns_service_ip      = "10.0.0.10"      # CoreDNS IP
    load_balancer_sku   = "standard"
  }

  # ---------- 5. MONITORING ----------
  oms_agent {
    log_analytics_workspace_id      = azurerm_log_analytics_workspace.aks.id
    msi_auth_for_monitoring_enabled = true
  }

  # ---------- 6. WORKLOAD IDENTITY (for Key Vault later) ----------
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  tags = var.tags

  # ---------- 7. CREATE ROLES FIRST ----------
  depends_on = [
    azurerm_role_assignment.control_plane_subnet,
    azurerm_role_assignment.control_plane_kubelet_operator,
  ]
}

# ---------- 8. USER NODE POOL (your apps) ----------
resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  mode                  = "User"
  vm_size               = var.user_node_vm_size # Standard_B2ms
  vnet_subnet_id        = azurerm_subnet.aks_nodes.id
  os_disk_size_gb       = 64

  auto_scaling_enabled = true # cluster autoscaler
  min_count            = 1
  max_count            = 2

  node_labels = {
    workload = "apps"
  }

  upgrade_settings {
    max_surge = "10%"
  }

  tags = var.tags
}