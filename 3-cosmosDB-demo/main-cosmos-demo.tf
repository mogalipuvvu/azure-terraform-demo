
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
  name     = "my3rdResourceGroup"
  location = "eastus"

  tags = {
    environment = "Terraform 3rd example"
  }
}

resource "azurerm_virtual_network" "mytf_vnet" {
  name                = "my3rdVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.myRG.name

  tags = {
    environment = "created CosmosDB using Terraform"
  }
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}
resource "azurerm_cosmosdb_account" "myCosmosDB" {

  name                      = "my-cosmos-db-srini-${random_integer.ri.result}"
  resource_group_name       = azurerm_resource_group.myRG.name
  location                  = azurerm_resource_group.myRG.location
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  enable_automatic_failover = false
  geo_location {
    location          = azurerm_resource_group.myRG.location
    failover_priority = 0
  }
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

}
