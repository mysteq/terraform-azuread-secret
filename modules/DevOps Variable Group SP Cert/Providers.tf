terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
    }

    azuredevops = {
      source = "microsoft/azuredevops"
    }

    pkcs12 = {
      source  = "chilicat/pkcs12"
      version = "0.2.5"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
  }
}

data "azuread_client_config" "current" {}