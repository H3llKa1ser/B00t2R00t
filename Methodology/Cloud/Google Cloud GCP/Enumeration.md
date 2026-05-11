# Enumeration

Tools:

1) iam-policy-visualize https://github.com/hac01/iam-policy-visualize

2) graphviz (sudo apt install)

3) GCPBucketBrute https://github.com/RhinoSecurityLabs/GCPBucketBrute

4) gcp-iam-brute https://github.com/hac01/gcp-iam-brute

## IAM Policies

### 1) Save output into a JSON file

    gcloud projects get-iam-policy PROJECT_NAME --format=json > project.json

### 2) Run script

    python3 main.py project.json

## Buckets

### 1) Enumerate buckets

    python3 gcpbucketbrute.py -f /tmp/token.json -k KEYWORD -s 10 -o output.log

## IAM

### 1) Enumerate IAM permissions

    python3 main.py --access-token $(gcloud auth print-access-token) --project-id $(gcloud config get-value project) --service-account-email $(gcloud auth list --filter=status:ACTIVE --format="value(account)")
