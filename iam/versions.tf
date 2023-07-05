terraform {
  required_version = ">= 1.0.0"
  required_providers {
    graphql = {
      source  = "sullivtr/graphql"
      version = "2.5.4"
    }
    ibm = {
      source  = "ibm-cloud/ibm"
      version = "1.54.0"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

