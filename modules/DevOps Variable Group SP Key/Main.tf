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
  display_name      = "DevOps Variable Group '${var.variable_group_name}' in the project '${var.devops_project_name}'"
  application_id    = data.azuread_application.app.id
  end_date_relative = "${(var.rotation_days + 14) * 24}h"
  rotate_when_changed = {
    rotation = time_rotating.schedule.id
  }
}

resource "azuredevops_variable_group" "vg" {
  project_id   = var.devops_project_id
  name         = var.variable_group_name
  description  = "Managed by Terraform"
  allow_access = var.allow_access

  variable {
    name  = var.clientid_secret_name
    value = data.azuread_application.app.client_id
  }

  variable {
    name         = var.clientsecret_secret_name
    secret_value = azuread_application_password.key.value
    is_secret    = true
  }

  variable {
    name  = var.tenantid_secret_name
    value = data.azuread_client_config.current.tenant_id
  }
}
