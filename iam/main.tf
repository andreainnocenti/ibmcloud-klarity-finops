resource "ibm_iam_service_id" "mca_service_id" {
  description = "Service ID for pulling this account's billing information into MCA."
  name        = "mca-service-id"
}

resource "ibm_resource_tag" "private_worker_service_id_tags" {
  resource_id = ibm_iam_service_id.mca_service_id.crn
  tags        = ["terraform", "mca", "finops"]
}

# Assign the necessary IAM access policies to the Service ID created
# Service: All Identity and Access enabled services; Resources: All resources; Resource Group Access: Viewer; Service Access: Reader; Platform Access: Viewer
resource "ibm_iam_service_policy" "all_iam_services" {
  description    = "All Identity and Access enabled services for all resources. Resource Group Access: Viewer; Service Access: Reader; Platform Access: Viewer."
  iam_service_id = ibm_iam_service_id.mca_service_id.id
  roles          = ["Reader", "Viewer"]
}

# Assign the necessary IAM access policies to the Service ID created
# Service: All Account Management services; Platform Access: Viewer
resource "ibm_iam_service_policy" "all_account_management" {
  account_management = true
  description        = "All Account Management services. Platform Access: Viewer."
  iam_service_id     = ibm_iam_service_id.mca_service_id.id
  roles              = ["Viewer"]
}

# Assign the necessary IAM access policies to the Service ID created
resource "ibm_iam_service_policy" "all_resource_groups" {
  description    = "All resource groups."
  iam_service_id = ibm_iam_service_id.mca_service_id.id
  roles          = ["Viewer"]
  resource_attributes {
    name  = "resourceType"
    value = "resource-group"
  }
}

# Create an API key for the Service ID created
resource "ibm_iam_service_api_key" "mca_service_id_api_key" {
  description    = "Authenticates access for MCA to pull billing information from this account. Created with Terraform."
  iam_service_id = ibm_iam_service_id.mca_service_id.iam_id
  name           = "${ibm_iam_service_id.mca_service_id.name}-api-key"
}
