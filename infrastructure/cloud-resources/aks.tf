resource "azurerm_resource_group" "rg" {
  name     = "colombia40-rg"
  location = "East US 2"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "colombia40-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "colombia40"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_E2bds_v5"
  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_resource_group.rg]
}