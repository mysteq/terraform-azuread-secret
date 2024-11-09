terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
    }

    azuredevops = {
      source = "microsoft/azuredevops"
    }
  }
}

data "azuread_client_config" "current" {}