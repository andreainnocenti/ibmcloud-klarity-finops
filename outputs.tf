output "global_tag_keys_new" {
  description = "New list of application and environment tag keys set as Mapping Rules on MCA, after mutations have been applied."
  value       = module.mapping_rules.global_tag_keys_new
}
