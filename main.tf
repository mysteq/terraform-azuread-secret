# Get app registration as data resource
data "azuread_application" "app" {
  client_id = var.client_id
}

# Create life cycle
resource "time_rotating" "schedule" {
  rotation_days = var.rotation_days
}

# Create key
resource "azuread_application_password" "key" {
  for_each          = var.type == "password" && var.rotation_type == "overlap" ? toset(["key1", "key2"]) : 
                      var.type == "password" ? toset(["key1"]) : 
                      toset([])
  display_name      = local.display_name
  application_id    = data.azuread_application.app.id
  end_date_relative = "${var.rotation_days * 24}h"

  rotate_when_changed = {
    rotation = time_rotating.schedule.id
  }
}

module "azurekeyvault" {
  source = "./modules/azurekeyvault"

  key_vault_id = var.key_vault_id
  client_id    = var.client_id

  clientid_secret_name    = "${var.name}-clientid"
  clientsecret_secret_name = "${var.name}-clientsecret"
  tenantid_secret_name = "${var.name}-tenantid"
}