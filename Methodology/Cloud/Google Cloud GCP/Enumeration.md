# Enumeration

Tools:

1) iam-policy-visualize https://github.com/hac01/iam-policy-visualize

2) graphviz (sudo apt install)

## IAM Policies

### 1) Save output into a JSON file

    gcloud projects get-iam-policy PROJECT_NAME --format=json > project.json

### 2) Run script

    python3 main.py project.json
