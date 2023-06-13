terraform {
  required_version = ">= 1.0.0"
  # Add any required providers below and uncomment
   required_providers {
     ibm = {
       source = "IBM-Cloud/ibm"
       # Use "greater than or equal to" range in modules
       version = ">= 1.45.0"
     }

     graphql = {
      source = "sullivtr/graphql"
      version = "2.5.4"
    }
   }
}

provider "graphql" {
  url = "${var.klarity_host_name}/graphql"
  headers = {
    "x-api-key" = "${var.klarity_api_id}/${var.klarity_api_secret}"
    "content-type" = "application/json"
  }
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}
