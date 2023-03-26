terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "mystorageandreibortas"
    container_name       = "tfstate"
    key                  = "log-terraform.tfstate"
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

data "azurerm_resource_group" "resource_group" {
  name     = "${var.name}-rg"
}

resource "azurerm_log_analytics_workspace" "Log_Analytics_WorkSpace" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = "${var.name}-${random_string.random.result}"
    location            = var.location
    resource_group_name = data.azurerm_resource_group.resource_group.name
    sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "Log_Analytics_Solution_ContainerInsights" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.Log_Analytics_WorkSpace.location
    resource_group_name   = data.azurerm_resource_group.resource_group.name
    workspace_resource_id = azurerm_log_analytics_workspace.Log_Analytics_WorkSpace.id
    workspace_name        = azurerm_log_analytics_workspace.Log_Analytics_WorkSpace.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}