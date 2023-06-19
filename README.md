# Deployable architecture to onboard an IBM Cloud account into IBM Multi-Cloud Accelerator (MCA) ✨

An EPX Deployable Architecture (DA) for adding an IBM Cloud account to a MCA instance. This DA provisions an IAM Service ID with the necessary permissions to pull resource and billing information.

> ❗ You will **require a paid account** to deploy this architecture into a private catalog.

## Usage

### Run pre-commit checks
```bash
pre-commit install
pre-commit run --all-files
```

### Apply Terraform configuration
```bash
terraform init
terraform plan
terraform apply
```

## Required IAM access policies

The API key to be used requires access to create Service IDs, API keys, and assign the following access policies:

| **Service**                              | **Resources** | **Resource Group Access** | **Service Access** | **Platform Access** |
| ---------------------------------------- | ------------- | ------------------------- | ------------------ | ------------------- |
| All Identity and Access enabled services | All resources | Viewer                    | Reader             | Viewer              | - |
| All Account Management services          | -             | -                         | -                  | Viewer              | - |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | 2.3.1 |
| <a name="requirement_graphql"></a> [graphql](#requirement\_graphql) | 2.5.4 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.54.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.1 |
| <a name="provider_graphql"></a> [graphql](#provider\_graphql) | 2.5.4 |
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.54.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam"></a> [iam](#module\_iam) | ./iam | n/a |
| <a name="module_mapping_rules"></a> [mapping\_rules](#module\_mapping\_rules) | ./mapping-rules | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ibmcloud_account_description"></a> [ibmcloud\_account\_description](#input\_ibmcloud\_account\_description) | Brief description of the IBM Cloud account to be added to MCA. | `string` | `"Added with Terraform and GraphQL"` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | API key for the IBM Cloud account to be added to the MCA instance. Must have the necessary permissions to create Service IDs and API keys. | `string` | n/a | yes |
| <a name="input_mca_account_owner_id"></a> [mca\_account\_owner\_id](#input\_mca\_account\_owner\_id) | ID corresponding to the MCA contact to be assigned to the target IBM Cloud account. Note that this ID can only be retrieved using MCA's API, since it's not available on the UI. | `string` | n/a | yes |
| <a name="input_mca_api_key_id"></a> [mca\_api\_key\_id](#input\_mca\_api\_key\_id) | ID corresponding to the MCA API key to be used for accessing the target instance. Must have the Full Access role. | `string` | n/a | yes |
| <a name="input_mca_api_key_secret"></a> [mca\_api\_key\_secret](#input\_mca\_api\_key\_secret) | API key corresponding to the target MCA instance to add an account to. Must have the Full Access role. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to use with the IBM Cloud Terraform provider. | `string` | `"us-south"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_global_tag_keys_new"></a> [global\_tag\_keys\_new](#output\_global\_tag\_keys\_new) | New list of application and environment tag keys set as Mapping Rules on MCA, after mutations have been applied. |
<!-- END_TF_DOCS -->
