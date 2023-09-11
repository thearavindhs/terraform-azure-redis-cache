terraform {

  required_version = "~> 1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3"
    }
  }
}

# use this only when you want to run terraform plan and do not use it in the module
# provider "azurerm" {

#   features {}
# }
