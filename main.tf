/********************************************************************
This file is used to implement the ROOT module.
*********************************************************************/

/**
* Add the IAM Service Id
*/
resource "ibm_iam_service_id" "klarity" {
  name        = "klarity data pull"
  description = "Added by finops deployable architecture to allow klarity to pull resources and billing information"
  tags = ["klarity", "finops"]
}

/**
* Create the necessary service policies on the service id
*/
resource "ibm_iam_service_policy" "all_iam_services" {
  iam_service_id = ibm_iam_service_id.klarity.id
  roles          = ["Reader", "Viewer"]
  description    = "All IAM Service Policy for Klarity"
}

resource "ibm_iam_service_policy" "all_account_management" {
  iam_service_id = ibm_iam_service_id.klarity.id
  roles          = ["Viewer"]
  description    = "View all Account for Klarity"
  account_management = true
}

resource "ibm_iam_service_policy" "all_resource_groups" {
  iam_service_id = ibm_iam_service_id.klarity.id
  roles          = ["Viewer"]
  description    = "View all Resource Groups for Klarity"
  resource_attributes {
    name  = "resourceType"
    value = "resource-group"
  }
}

/**
* Create the api key for the service id used by klarity to collect the ibm cloud data
*/
resource "ibm_iam_service_api_key" "klarity_service_key" {
  name = "klarity-data-pull"
  iam_service_id = ibm_iam_service_id.klarity.iam_id
}

/**
* Add the IBM Cloud Account to Klarity
*/
resource "graphql_mutation" "account_mutation" {
  mutation_variables = {
    "accountId" = "${ibm_iam_service_api_key.klarity_service_key.account_id}",
    "ownerId" = var.klarity_account_ownerId
    "creds": jsonencode("{ \"apikey\": \"${ibm_iam_service_api_key.klarity_service_key.apikey}\" }")
    "displayName": "${var.ibmcloud_account_name}"
    "description": "${var.ibmcloud_account_description}"
  }
  compute_from_create = true
  compute_mutation_keys = {
    "id" = "addAccountV2.id"
  }

  create_mutation = file("./graphql/mutations/account/addAccountV2.graphql")
  update_mutation = file("./graphql/mutations/account/updateAccountV2.graphql")
  delete_mutation = file("./graphql/mutations/account/removeAccountV2.graphql")
  read_query      = file("./graphql/queries/account/accountV2.graphql")
}