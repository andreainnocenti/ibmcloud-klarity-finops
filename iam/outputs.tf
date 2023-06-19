output "mca_service_id_api_key" {
  description = "Secret for the Service ID API key that has been created to allow the MCA instace to pull cost data from the target IBM Cloud account."
  value       = ibm_iam_service_api_key.mca_service_id_api_key.apikey
}
