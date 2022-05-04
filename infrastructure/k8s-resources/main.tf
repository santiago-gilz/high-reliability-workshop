terraform {
  required_version = "1.1.9"
  backend "azurerm" {
    resource_group_name  = "state-rg"
    storage_account_name = "col40tfstates"
    container_name       = "tfstate"
    key                  = "colombia40-k8s-resources.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
  }
}

provider "azurerm" {
  features {

  }
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  resource_group_name = var.aks_rg
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
    username               = data.azurerm_kubernetes_cluster.aks.kube_config.0.username
    password               = data.azurerm_kubernetes_cluster.aks.kube_config.0.password
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
  }
}
