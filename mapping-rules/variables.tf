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

variable "mca_graphql_server_url" {
  default     = "https://api.cnop-int.us.nordcloudapp.com"
  description = "The GraphQL API url that the provider will use to make requests."
  type        = string
}
