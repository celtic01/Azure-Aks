terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "mystorageandreibortas"
    container_name       = "tfstate"
    key                  = "acr-terraform.state"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "random" {
 
}

provider "azurerm" {
  features {}
}

resource "random_string" "random" {
  length           = 16
  special          = false
}

resource "azurerm_resource_group" "acr_resource_group" {
  name     = "${var.name}-rg"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.name}acr${random_string.random.result}"
  resource_group_name = azurerm_resource_group.acr_resource_group.name
  location            = azurerm_resource_group.acr_resource_group.location
  sku                 = "Standard"
  admin_enabled       = false
}
