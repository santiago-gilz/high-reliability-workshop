resource "azurerm_resource_group" "rg" {
  name     = "colombia40-rg"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "colombia40-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "colombia40"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_D4s_v4"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 2
  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_resource_group.rg]
}