#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Get command-line arguments
ACCOUNTS=$1
OWNER_EMAIL=$2

if ! jq -e .data >/dev/null 2>&1 <<<"$ACCOUNTS"; then
    exit "could not parse json string"
fi

# Return json element containing the email in input
if key=$(echo $ACCOUNTS | jq -re --arg owner_email "$OWNER_EMAIL" '.data.people[] | select(.email==$owner_email)')
then
    echo "$key"
else 
    exit "Email $OWNER_EMAIL not found, allowed values are: $(echo $ACCOUNTS |jq -r '[.data.people[].email]|join(", ")')"
fi
