variable "type" {
  description = "(Optional) The type of the secret to rotate. Can be of type 'password' or 'certificate'. Defaults to 'password'."
  type        = string
  default     = "password"
}

variable "rotation_type" {
  description = "(Optional) The type of rotation to perform. Can be of type 'overlap' or 'none'. Defaults to 'overlap'."
  type        = string
  default     = "overlap"
}

variable "destination" {
  description = "(Optional) The destination of the secret to rotate. Can be of type 'keyvault' or 'variablegroup'."
  type        = string
  default     = "keyvault"
}

variable "client_id" {
  type        = string
  description = "The application id of the app registration to create a client secret for"
}

variable "rotation_days" {
  type        = number
  description = "(Optional) The number of days to wait before rotating the secret. Defaults to 180."
  default     = 180
}

# Key Vault specific variables
variable "key_vault_id" {
  type        = string
  description = "Id of the keyvault to put the secrets in"
  default     = null
}

variable "key_vault_secret_name" {
  type        = string
  description = "The name of the clientsecret key vault secret"
  default     = null
}

# Azure DevOps Variable Group specific variables
variable "devops_project_name" {
  type        = string
  description = "The Azure DevOps project name, output from the azuredevops_project resource."
  default     = null
}

variable "devops_project_id" {
  type        = string
  description = "The Azure DevOps project id, output from the azuredevops_project resource."
  default     = null
}

variable "variable_group_name" {
  type        = string
  description = "The name of the service connection in Azure DevOps"
  default     = null
}
