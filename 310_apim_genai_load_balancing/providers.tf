terraform {

  required_version = ">=1.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.14.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">= 2.1.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "dcef7009-6b94-4382-afdc-17eb160d709a"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azapi" {
}
