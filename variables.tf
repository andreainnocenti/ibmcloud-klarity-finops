##############################################################################
# Input Variables
##############################################################################

#variable "myvariable" {
#  type        = string
#  description = "A description of my variable"
#  default     = ""
#}

##############################################################################

variable "ibmcloud_account_name" {
  description = "IBM Cloud account name"
  type        = string
}

variable "ibmcloud_api_key" {
  description = "API Key for IBM Cloud"
  type        = string
  sensitive   = true
}

variable "ibmcloud_account_description" {
  description = "Description of the account to onboard"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
  default     = "us-south"
}

variable "klarity_host_name" {
  description = "the url to your klarity host"
  type        = string
  default     = "https://api.cnop-int.us.nordcloudapp.com"
}


variable "klarity_api_id" {
  description = "the url to your klarity host"
  type        = string
}

variable "klarity_api_secret" {
  description = "the url to your klarity host"
  type        = string
  sensitive   = true
}

variable "klarity_account_ownerId" {
  description = "the url to your klarity host"
  type        = string
}
