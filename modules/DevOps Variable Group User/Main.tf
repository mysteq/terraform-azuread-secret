# Create life cycle
resource "time_rotating" "schedule" {
  rotation_days = 90
}

data "azuread_domains" "initial" {
  only_initial = true
}

# Generate rotating password
resource "random_password" "password" {
  length           = 45
  special          = true
  override_special = "_%@"
  keepers = {
    rotation = time_rotating.schedule.id
  }
}

# Create user
resource "azuread_user" "user" {
  user_principal_name = var.user_principal_name_suffix == null ? "${var.user_principal_name_prefix}@${data.azuread_domains.initial.domains[0].domain_name}" : "${var.user_principal_name_prefix}@${var.user_principal_name_suffix}"
  display_name        = var.user_display_name
  password            = random_password.password.result
  account_enabled     = true
}

resource "azuredevops_variable_group" "vg" {
  project_id  = var.devops_project_id
  name        = var.variable_group_name
  description = "Managed by Terraform"

  variable {
    name  = var.username_secret_name
    value = azuread_user.user.user_principal_name
  }

  variable {
    name         = var.password_secret_name
    secret_value = random_password.password.result
    is_secret    = true
  }

  variable {
    name  = var.tenantid_secret_name
    value = data.azuread_client_config.current.tenant_id
  }
}