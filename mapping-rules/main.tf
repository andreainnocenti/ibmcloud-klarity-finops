locals {
  projects_application_tag_keys = ["project"]
  projects_environment_tag_keys = ["configuration"]
}

# Mapping Rules before the mutation is applied
data "graphql_query" "global_tag_keys_before" {
  query_variables = {}
  query           = file("./graphql/queries/mapping-rule/globalTagKeys.graphql")
}

# Mapping Rules after the mutation is applied
data "graphql_query" "global_tag_keys_after" {
  depends_on      = [graphql_mutation.set_mapping_rules]
  query_variables = {}
  query           = file("./graphql/queries/mapping-rule/globalTagKeys.graphql")
}

# Set Mapping Rules using MCA's GraphQL API
resource "graphql_mutation" "set_mapping_rules" {
  depends_on = [data.graphql_query.global_tag_keys_before]

  # The mutation does not return anything
  compute_mutation_keys = {}
  compute_from_create   = false

  mutation_variables = { # Set tag keys to be the current keys already set in the instance, plus those specified in this Terraform configuration. If the NULL indicator is present from a previous terraform destroy, remove it.
    "applicationTagKeys" = jsonencode(distinct(concat(jsondecode(data.graphql_query.global_tag_keys_before.query_response).data.globalTagKeys.application, local.projects_application_tag_keys)))
    "environmentTagKeys" = jsonencode(distinct(concat(jsondecode(data.graphql_query.global_tag_keys_before.query_response).data.globalTagKeys.environment, local.projects_environment_tag_keys)))
  }

  delete_mutation_variables = { # Set tag keys to be the current keys already set in the instance. This avoids Terraform attempting to remove ALL current tags and throwing an API error.
    "applicationTagKeys" = jsonencode(jsondecode(data.graphql_query.global_tag_keys_before.query_response).data.globalTagKeys.application)
    "environmentTagKeys" = jsonencode(jsondecode(data.graphql_query.global_tag_keys_before.query_response).data.globalTagKeys.environment)
  }

  create_mutation = file("./graphql/mutations/mapping-rule/updateGlobalTagKeys.graphql")
  delete_mutation = file("./graphql/mutations/mapping-rule/updateGlobalTagKeys.graphql")
  update_mutation = file("./graphql/mutations/mapping-rule/updateGlobalTagKeys.graphql")
  read_query      = file("./graphql/queries/mapping-rule/globalTagKeys.graphql")
}
