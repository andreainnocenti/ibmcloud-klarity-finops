locals {
  get_ibmcloud_account_name_file_name = "scripts/get_ibmcloud_account_name.sh"
  ibmcloud_account_id                 = data.ibm_iam_account_settings.ibmcloud_account_settings.account_id
  mca_graphql_server_url              = "https://api.cnop-int.us.nordcloudapp.com"
}

data "ibm_iam_account_settings" "ibmcloud_account_settings" {}

# Get an IBM Cloud account's name with the API
data "external" "get_ibmcloud_account_name" { # TODO: Update section once an IBM Cloud account's name is available through Terraform
  program = [
    "bash",
    "${path.module}/${local.get_ibmcloud_account_name_file_name}",
    module.iam.mca_service_id_api_key,
    local.ibmcloud_account_id
  ]
}

# Add IBM Cloud account to MCA instance using MCA's GraphQL API
resource "graphql_mutation" "add_account_v2" {
  depends_on = [module.iam]
  mutation_variables = {
    "accountDescription" = var.ibmcloud_account_description
    "accountDisplayName" = data.external.get_ibmcloud_account_name.result.account_name
    "accountId"          = local.ibmcloud_account_id
    "accountOwnerId"     = var.mca_account_owner_id
    "creds"              = jsonencode("{\"apikey\": \"${module.iam.mca_service_id_api_key}\"}")
  }
  compute_mutation_keys = { # Output of addAccountV2 to be used in the update and delete queries. This helps manage state.
    "id" = "addAccountV2.id"
  }
  compute_from_create              = true
  enable_remote_state_verification = false
  # Required for provider to keep track of state
  create_mutation = file("./graphql/mutations/account/addAccountV2.graphql")
  delete_mutation = file("./graphql/mutations/account/removeAccountV2.graphql")
  update_mutation = file("./graphql/mutations/account/updateAccountV2.graphql")
  read_query      = file("./graphql/queries/account/accountV2.graphql")
}

# Create Service ID, corresponding API key, and assign all necessary permissions for MCA to pull cost data from this target IBM Cloud account
module "iam" {
  source                 = "./iam"
  mca_graphql_server_url = local.mca_graphql_server_url
  region                 = var.region
  ibmcloud_api_key       = var.ibmcloud_api_key
}

module "mapping_rules" {
  source                 = "./mapping-rules"
  mca_api_key_id         = var.mca_api_key_id
  mca_api_key_secret     = var.mca_api_key_secret
  mca_graphql_server_url = local.mca_graphql_server_url
}
