# Get app registration as data resource
data "azuread_application" "app" {
  client_id = var.client_id
}

# Create life cycle
resource "time_rotating" "schedule" {
  rotation_days = 90
}

# RSA key of size 4096 bits
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "certificate" {
  private_key_pem = tls_private_key.private_key.private_key_pem

  subject {
    common_name  = var.common_name_fqdn
    organization = "Amesto Fortytwo AS"
  }

  validity_period_hours = 87600 # 10 years until support for private key rollover is supported

  allowed_uses = [
    "key_encipherment",
    "digital_signature"
  ]
}

# Create cert
resource "azuread_application_certificate" "cert" {
  # display_name          = "DevOps Variable Group '${var.variable_group_name}' in the project '${var.devops_project_name}'"
  application_object_id = data.azuread_application.app.id
  type                  = "AsymmetricX509Cert"
  value                 = tls_self_signed_cert.certificate.cert_pem
  end_date_relative     = "87000h" # 10 years until support for private key rollover is supported

  # rotate_when_changed = {
  #   rotation = time_rotating.schedule.id
  # }
}

resource "random_password" "password" {
  length  = 16
  special = false
  keepers = {
    date = time_rotating.schedule.id
  }
}

resource "pkcs12_from_pem" "certificate" {
  password        = random_password.password.result
  cert_pem        = tls_self_signed_cert.certificate.cert_pem
  private_key_pem = tls_private_key.private_key.private_key_pem
}

resource "azuredevops_variable_group" "vg" {
  project_id  = var.devops_project_id
  name        = var.variable_group_name
  description = "Managed by Terraform"

  variable {
    name  = var.clientid_secret_name
    value = data.azuread_application.app.client_id
  }

  variable {
    name         = "${var.clientcertificate_secret_name}_part1"
    secret_value = substr(pkcs12_from_pem.certificate.result, 4096 * 0, 4096)
    is_secret    = true
  }

  variable {
    name         = "${var.clientcertificate_secret_name}_part2"
    secret_value = substr(pkcs12_from_pem.certificate.result, 4096 * 1, 4096)
    is_secret    = true
  }

  variable {
    name         = "${var.clientcertificate_secret_name}_part3"
    secret_value = substr(pkcs12_from_pem.certificate.result, 4096 * 2, 4096)
    is_secret    = true
  }

  variable {
    name         = "${var.clientcertificate_secret_name}_part4"
    secret_value = substr(pkcs12_from_pem.certificate.result, 4096 * 3, 4096)
    is_secret    = true
  }

  variable {
    name         = var.clientcertificatepassword_secret_name
    secret_value = random_password.password.result
    is_secret    = true
  }

  variable {
    name  = var.tenantid_secret_name
    value = data.azuread_client_config.current.tenant_id
  }
}