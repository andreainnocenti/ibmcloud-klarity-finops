variable "ibmcloud_api_key" {
  description = "API key for the IBM Cloud account to be added to the MCA instance. Must have the necessary permissions to create Service IDs and API keys."
  sensitive   = true
  type        = string
}

variable "region" {
  default     = "us-south"
  description = "Region to use with the IBM Cloud Terraform provider."
  type        = string
}
