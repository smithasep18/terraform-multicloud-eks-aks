resource "azurerm_kubernetes_cluster" "main" {

  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_prefix = "${var.cluster_name}-dns"

  default_node_pool {

    name       = "default"

    node_count = 1

    vm_size    = "Standard_D2s_v7"

    vnet_subnet_id = var.subnet_id

  }

  identity {

    type = "SystemAssigned"

  }

  network_profile {
  network_plugin    = "azure"
  load_balancer_sku = "standard"
  service_cidr      = var.service_cidr
  dns_service_ip    = var.dns_service_ip
}

}