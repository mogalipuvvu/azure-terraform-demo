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
        environment = "Terraform 1st example"
    }
}

resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "myFirstVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.myRG.name

    tags = {
        environment = "created V-Net using Terraform"
    }
}
