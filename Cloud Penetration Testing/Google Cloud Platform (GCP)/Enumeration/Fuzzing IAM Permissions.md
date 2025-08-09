# Fuzzing IAM Permissions using the "testIAMPermissions" feature

## Use case:

### If our account does not have permissions to use the "getIAMPolicy" feature, we can fuzz for permissiosn by using this feature.

### There is a specific tool that we can use for fuzzing permissions.

## Tool: https://github.com/hac01/gcp-iam-brute.git

## Usage:

    python3 main.py --access-token $(gcloud auth print-access-token) --project-id $(gcloud config get-value project) --service-account-email $(gcloud auth list --filter=status:ACTIVE --format="value(account)")

### OR we may use a bash script that utilized cURL for that. (Script is in the scripts folder in this repo)
