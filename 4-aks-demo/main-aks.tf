
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.40.0"
    }
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  features {}
}

resource "azurerm_resource_group" "myRG" {
  name     = "my4thdResourceGroup"
  location = "eastus"

  tags = {
    environment = "Terraform 4th example"
  }
}

resource "azurerm_virtual_network" "mytf_vnet" {
  name                = "my4thVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.myRG.name

  tags = {
    environment = "created AKS using Terraform"
  }
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_kubernetes_cluster" "myAKS" {

  name = "firstAKSCluster"
  
}
