variable "devops_project_name" {
  type        = string
  description = "The Azure DevOps project name, output from the azuredevops_project resource."
}

variable "devops_project_id" {
  type        = string
  description = "The Azure DevOps project id, output from the azuredevops_project resource."
}

variable "variable_group_name" {
  type        = string
  description = "The name of the service connection in Azure DevOps"
}

variable "user_principal_name_prefix" {
  type        = string
  description = "What goes infront of the @"
}

variable "user_principal_name_suffix" {
  type        = string
  description = "What goes after the @"
  default     = null
}

variable "user_display_name" {
  type        = string
  description = "Displayname of the user"
}

variable "username_secret_name" {
  type        = string
  description = "The name of the username secret"
  default     = "username"
}

variable "tenantid_secret_name" {
  type        = string
  description = "The name of the tenantid secret"
  default     = "tenantid"
}

variable "password_secret_name" {
  type        = string
  description = "The name of the password secret"
  default     = "password"
}