# Valid Credentials

## Authenticate

Tool: https://github.com/RhinoSecurityLabs/pacu

### 1) Set the access key, access key ID and region name

    aws configure

### 2) Set keys in Pacu framework

    ./cli.py
    set_keys    

### 3) Verify identity (like whoami)

    aws sts get-caller-identity

### 4) Situational Awareness (Pacu)

    run iam__bruteforce_permissions

## IAM

### 1) Users

Enumerate current user

    aws iam get-user

Enumerate groups for a specific user

    aws iam list-groups-for-user --user-name USERNAME

### 2) Policies

List attached user policies

    aws iam list-attached-user-policies --user-name USERNAME

List inline policies

    aws iam list-user-policies --user-name USERNAME

Enumerate a specific policy

    aws iam get-policy --policy-arn arn:aws:iam::AWS_ACCOUNT_ID:policy/POLICY_NAME

Enumerate a specific inline user policy

    aws iam get-user-policy --user-name USERNAME --policy-name POLICY_NAME

Enumerate policy versions of a specific policy

    aws iam list-policy-versions --policy-arn arn:aws:iam::aws:policy/POLICY_NAME

See more detailed for a specific version of a policy

    aws iam get-policy-version --policy-arn arn:aws:iam::aws:policy/POLICY_NAME --version-id vNUM

List attached role policies

    aws iam list-attached-role-policies --role-name ROLE_NAME

### 3) Roles

Get information about a role

    aws iam get-role --role-name ROLE_NAME

### 4) Access Keys

Check which user the key belongs to

    aws iam get-access-key-last-used --access-key-id 'AKIA......' --query 'UserName'

## S3

### 1) List S3 Buckets

    aws s3 ls
