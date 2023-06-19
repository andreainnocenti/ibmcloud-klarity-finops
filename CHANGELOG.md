# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!--
Semantic versioning: MAJOR.MINOR.PATCH
- MAJOR when breaking backward compatibility,
- MINOR when adding a new feature which doesn’t break compatibility,
- PATCH when fixing a bug without breaking compatibility

Types of changes:
- Added: new features.
- Changed: changes in existing functionality.
- Deprecated: soon-to-be removed features.
- Removed: now removed features.
- Fixed: any bug fixes.
- Security: vulnerabilities.
-->

<!-- ## [Unreleased] -->

<!--
People can see what changes they might expect in upcoming releases.
At release time, you can move the Unreleased section changes into a new release version section.
-->

## \[1.1.0\] - 2023-06-15

### Added

- Add Application and Environment mapping rules to an IBM Multi-Cloud Accelerator (MCA) instance. ([#15](https://github.ibm.com/cloud-finops/issues/issues/15))
- Add capability to get IBM Cloud account name using IBM's `accounts` API. ([#15](https://github.ibm.com/cloud-finops/issues/issues/15))
- Add pre-commit checks. ([#15](https://github.ibm.com/cloud-finops/issues/issues/15))

### Changed

- Extraction of an IBM Cloud account number using an API key should now use the [`ibm_iam_account_settings`](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/iam_account_settings) resource. ([#15](https://github.ibm.com/cloud-finops/issues/issues/15))
- Decrease number of variables that are exposed to the user. ([#15](https://github.ibm.com/cloud-finops/issues/issues/15))
- Add descriptions to all Terraform variables used. ([#15](https://github.ibm.com/cloud-finops/issues/issues/15))
- Extract IAM access management set up into separate module. ([#15](https://github.ibm.com/cloud-finops/issues/issues/15))

## \[1.0.0\] - 2023-05-24

### Added

- First public version
