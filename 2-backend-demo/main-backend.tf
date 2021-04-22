terraform {

  backend azurerm {
    resource_group_name  = "myFirstResourceGroup"
    storage_account_name = "1azurestorage"
    container_name       = "tf-state-folder"
    key                  = "tf.state.key-1"
  }
}


provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

resource "azurerm_resource_group" "myRG" {
  name     = "my2ndResourceGroup"
  location = "eastus"

  tags = {
    environment = "Terraform 2nd example"
  }
}

resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = "my2ndVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.myRG.name

  tags = {
    environment = "created backend using Terraform"
  }
}
