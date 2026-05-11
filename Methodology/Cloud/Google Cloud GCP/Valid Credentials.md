# Valid Credentials

Tools:

1) Google CLI https://cloud.google.com/sdk/docs/install-sdk

## Authenticate

### 1) Login with a google account

    gcloud auth login

### 2) Remove existing authenticated sessions

    gcloud auth revoke --all

## Google Storage

### 1) Buckets

List bucket contents

    gcloud storage buckets list gs://BUCKET_NAME

OR

    gsutil ls gs://BUCKET_NAME

Return more information about a file

    gsutil stat gs://BUCKET_NAME/index.html

Download a file

    gsutil cp gs://BUCKET_NAME/file.txt .

