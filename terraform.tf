terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.21.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=3.0.0"
    }
  }
}
