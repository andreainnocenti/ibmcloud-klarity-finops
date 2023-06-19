output "global_tag_keys_new" {
  description = "New list of application and environment tag keys set as Mapping Rules on MCA, after mutations have been applied."
  value       = jsondecode(data.graphql_query.global_tag_keys_after.query_response).data.globalTagKeys
}
