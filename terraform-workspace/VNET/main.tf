terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "mystorageandreibortas"
    container_name       = "tfstate"
    key                  = "vnet-terraform.state"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# using resource group from ./terraform-workspace/ACR
data "azurerm_resource_group" "resource_group" {
  name     = "${var.name}-rg"
}

resource "azurerm_virtual_network" "virtual_network" {
  name =  "${var.name}-vnet"
  location = var.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  address_space = [var.network_address_space]
}

resource "azurerm_subnet" "aks_subnet" {
  name = var.aks_subnet_address_name
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes = [var.aks_subnet_address_prefix]
}

resource "azurerm_subnet" "app_gwsubnet" {
  name = var.subnet_address_name
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes = [var.subnet_address_prefix]
}