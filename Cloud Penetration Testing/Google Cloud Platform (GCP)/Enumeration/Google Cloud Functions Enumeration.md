# Google Cloud Functions GCF Enumeration

## Description

### Google Cloud Function code gets stored in a Google Cloud Storage bucket. Although we currently don't know the exact bucket name, it's worth noting that GCP uses a predictable naming format for Cloud Function buckets! The bucket naming format is gcf-sources-BUILD_NUMBER-REGION

## Commands

 - curl -H "Authorization: Bearer $ACCESS_TOKEN" \
    "https://cloudfunctions.googleapis.com/v1/projects/PROJECT_NAME/locations/-/functions" (Enumerate functions via the GCP API)

