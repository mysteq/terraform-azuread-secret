resource "azurerm_key_vault_secret" "clientid" {
  name         = var.clientid_secret_name
  value        = var.client_id
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "clientsecret" {
  name         = var.clientsecret_secret_name
  value        = var.client_secret
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "tenantid" {
  name         = var.tenantid_secret_name
  value        = var.tenant_id
  key_vault_id = var.key_vault_id
}
