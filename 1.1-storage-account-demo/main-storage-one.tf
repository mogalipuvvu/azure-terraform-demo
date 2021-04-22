provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

resource "azurerm_resource_group" "myRG" {
  name     = "myFirstResourceGroup"
  location = "eastus"

  tags = {
    environment = "Terraform - Azure Storage example"
  }
}

resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = "myFirstVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.myRG.name

  tags = {
    environment = "created Azure Storage using Terraform"
  }
}

resource "azurerm_storage_account" "myStorageAccount" {

  resource_group_name      = azurerm_resource_group.myRG.name
  name                     = "1azurestorage"
  account_tier             = "standard"
  location                 = azurerm_resource_group.myRG.location
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "name" {

  name                  = "tf-state-folder"
  storage_account_name  = azurerm_storage_account.myStorageAccount.name
#   key                   = "tf.state.key-1"
  container_access_type = "private"
}
