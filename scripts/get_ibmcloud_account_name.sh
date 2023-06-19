#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Get command-line arguments
IBMCLOUD_API_KEY=$1
IBMCLOUD_ACCOUNT_ID=$2

# Get Bearer Access Token for the API key provided
BEARER_ACCESS_TOKEN=$(curl -X POST "https://iam.cloud.ibm.com/identity/token" -H "content-type: application/x-www-form-urlencoded" -H "accept: application/json" -d "grant_type=urn%3Aibm%3Aparams%3Aoauth%3Agrant-type%3Aapikey&apikey=${IBMCLOUD_API_KEY}" | jq -r '.access_token')

# Retrieve the IBM Cloud account name corresponding to the API key provided
IBMCLOUD_ACCOUNT_NAME=$(curl -s "https://accounts.cloud.ibm.com/coe/v2/accounts/$IBMCLOUD_ACCOUNT_ID" --header "Authorization: $BEARER_ACCESS_TOKEN" --header 'Content-Type: application/json' | jq -r '.entity.name')
jq -n --arg account_name "$IBMCLOUD_ACCOUNT_NAME" '{"account_name":$account_name}'
