locals {
  display_name = var.destination == "keyvault" ?
    "Key Vault '${local.key_vault_name}' in subscriptionid '${data.azurerm_client_config.current.subscription_id}'" :
    "Variable Group '${var.variable_group_name}' in project '${var.project_name}'"
}