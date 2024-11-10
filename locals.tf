locals {
  key_vault_name = reverse(split("/", var.key_vault_id))[0]

  display_name = (var.destination == "keyvault" ?
    "Key Vault '${local.key_vault_name}' in subscriptionid '${data.azurerm_client_config.current.subscription_id}'" :
  "Variable Group '${var.variable_group_name}' in project '${var.devops_project_name}'")
}
