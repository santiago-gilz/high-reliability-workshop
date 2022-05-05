resource "azurerm_resource_group" "build-rg" {
  name     = "build-rg"
  location = "West Europe"
}

resource "azurerm_virtual_network" "build-vnet" {
  name                = "build-ss"
  resource_group_name = azurerm_resource_group.build-rg.name
  location            = azurerm_resource_group.build-rg.location
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.build-rg.name
  virtual_network_name = azurerm_virtual_network.build-vnet.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_linux_virtual_machine_scale_set" "build-ss" {
  name                = "build-ss"
  resource_group_name = azurerm_resource_group.build-rg.name
  location            = azurerm_resource_group.build-rg.location
  sku                 = "Standard_D2s_v3"
  instances           = 1
  admin_username      = "adminuser"

  identity {
    type = "SystemAssigned"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/build-ss.pub")
  }

  source_image_id = "/subscriptions/19d9fdcf-da26-4de4-a421-af41f060950c/resourceGroups/image-rg/providers/Microsoft.Compute/galleries/compute_gallery/images/build-image/versions/0.0.1"

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "build-ni"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.internal.id
    }
  }

  lifecycle {
    ignore_changes = [tags, automatic_os_upgrade_policy, overprovision, single_placement_group]
  }
}