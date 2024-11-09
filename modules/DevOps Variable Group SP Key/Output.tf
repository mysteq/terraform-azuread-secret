output "clientsecret" {
  description = "The generated clientsecret"
  value       = azuread_application_password.key.value
}