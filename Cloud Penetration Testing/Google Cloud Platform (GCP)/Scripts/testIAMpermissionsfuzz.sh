#!/bin/bash

# Set your Google Cloud API key or access token
ACCESS_TOKEN="$(gcloud auth print-access-token)"
# Set the project ID and service account email
PROJECT_ID="$(gcloud config get-value project)"
SERVICE_ACCOUNT_EMAIL="$(gcloud auth list --filter=status:ACTIVE --format="value(account)")"

# Set the permissions you want to test
PERMISSIONS=("resourcemanager.projects.get" "artifactregistry.repositories.get" "storage.buckets.get" "compute.instances.list" "iam.serviceAccounts.implicitDelegation")


# Make the curl request to test permissions
curl -X POST "https://cloudresourcemanager.googleapis.com/v1/projects/${PROJECT_ID}:testIamPermissions" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  --data "{
    \"permissions\": $(printf '%s\n' "${PERMISSIONS[@]}" | jq -R . | jq -s .)
  }"
