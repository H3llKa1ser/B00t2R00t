# Valid Credentials

Tools:

1) Google CLI https://cloud.google.com/sdk/docs/install-sdk

## Authenticate

### 1) Login with a google account

    gcloud auth login

### 2) Authenticate with a service account via a key file

    gcloud auth activate-service-account --key-file=token.json

### 3) Impersonate a service account

    gcloud --impersonate-service-account=SERVICE_ACCOUNT_NAME projects add-iam-policy-binding PROJECT_ID --member='user:USERNAME@gmail.com' --role='ROLE_NAME'

### 4) Remove existing authenticated sessions

    gcloud auth revoke --all

### 5) Print access token

    gcloud auth print-access-token

## Users and accounts

### 1) Validate account details

    gcloud config list account

### 2) Impersonate a service account

    gcloud config set auth/impersonate_service_account SERVICE_ACCOUNT_NAME

Unset impersonation configuration

    gcloud config unset auth/impersonate_service_account

## Google Storage

### 1) Buckets

List bucket contents of a specific project

    gcloud storage ls gs://BUCKET_NAME --project=PROJECT_NAME

List bucket contents

    gcloud storage buckets list gs://BUCKET_NAME

OR

    gsutil ls gs://BUCKET_NAME

Return more information about a file

    gsutil stat gs://BUCKET_NAME/index.html

Download a file

    gsutil cp gs://BUCKET_NAME/file.txt .

## Projects

### 1) IAM Policies

Check IAM Policies set at the project level

    gcloud projects get-iam-policy PROJECT_NAME --format=json

Return the roles bound to a current user

    gcloud projects get-iam-policy PROJECT_NAME --flatten="bindings[].members" --format='table(bindings.role, bindings.members)' --filter="bindings.members:USERNAME@gmail.com"

### 2) Config

Configure the project setting

    gcloud config set project PROJECT_NAME

## IAM

### 1) Roles

Examine a role

    gcloud iam roles describe ROLE_NAME --project=PROJECT_NAME

### 2) Service Accounts

List IAM policies for a service account

    gcloud iam service accounts get-iam-policy SERVICE_ACCOUNT_NAME
    
## Secrets

### 1) List secrets on a specific project

    gcloud secrets list --project=PROJECT_NAME

### 2) Get secrets

    gcloud secrets versions access latest --secret=SECRET_NAME --project=PROJECT_NAME

## SQL

### 1) Instances

List instances

    gcloud instances list --project=PROJECT_NAME

## Google Cloud Source Repositories

### 1) List repositories

    gcloud source repos list --project=PROJECT_NAME

### 2) Clone repository

    gcloud source repos clone REPOSITORY_NAME --project=PROJECT_NAME

