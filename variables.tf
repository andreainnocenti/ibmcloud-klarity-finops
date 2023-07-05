variable "ibmcloud_account_description" {
  default     = "Added with Terraform and GraphQL"
  description = "Brief description of the IBM Cloud account to be added to MCA."
  type        = string
}

variable "ibmcloud_api_key" {
  description = "API key for the IBM Cloud account to be added to the MCA instance. Must have the necessary permissions to create Service IDs and API keys."
  sensitive   = true
  type        = string
}

variable "mca_account_owner_email" { 
  description = "Email corresponding to the MCA contact to be assigned to the target IBM Cloud account."
  type        = string
}

variable "mca_api_key_id" {
  description = "ID corresponding to the MCA API key to be used for accessing the target instance. Must have the Full Access role."
  sensitive   = true
  type        = string
}

variable "mca_api_key_secret" {
  description = "API key corresponding to the target MCA instance to add an account to. Must have the Full Access role."
  sensitive   = true
  type        = string
}

variable "region" {
  default     = "us-south"
  description = "Region to use with the IBM Cloud Terraform provider."
  type        = string
}
