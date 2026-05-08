# Valid Credentials

## Authenticate

Tools: 

1) Pacu https://github.com/RhinoSecurityLabs/pacu

2) aws-enumerator https://github.com/shabarkin/aws-enumerator

### 1) Set the access key, access key ID and region name

AWS CLI

    aws configure

Pacu framework

    ./cli.py
    set_keys    

aws-enumerator (Edit .env file)

    aws-enumerator cred

### 2) Verify identity (like whoami)

    aws sts get-caller-identity

### 4) Situational Awareness 

Pacu

    run iam__bruteforce_permissions

aws-enumerator

    aws-enumerator enum --services all

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

See more details for a specific version of a policy

    aws iam get-policy-version --policy-arn arn:aws:iam::aws:policy/POLICY_NAME --version-id vNUM

List attached role policies

    aws iam list-attached-role-policies --role-name ROLE_NAME

### 3) Roles

Get information about a role

    aws iam get-role --role-name ROLE_NAME

### 4) Access Keys

Check which user the key belongs to

    aws iam get-access-key-last-used --access-key-id 'AKIA......' --query 'UserName'

## DynamoDB

### 1) List tables

    aws dynamodb list-tables

### 2) Describe a specific table

    aws dynamodb describe-table --table TABLE_NAME

### 3) Download table values of a specific table

    aws dynamodb scan --table-name TABLE_NAME > output.json

## S3

Use --no-sign-request if querying a public S3 bucket (can be used for each command below)

S3 Bucket names wordlist download

    wget https://raw.githubusercontent.com/koaj/aws-s3-bucket-wordlist/master/list.txt

Regions wordlist

    us-west-1
    us-west-2
    us-east-1
    us-east-2
    cn-north-1
    cn-northwest-1
    eu-central-1
    eu-north-1
    eu-west-1
    eu-west-2
    eu-west-3
    ap-northeast-1
    ap-northeast-2
    ap-northeast-3
    ap-south-1
    ap-southeast-1
    ap-southeast-2
    ca-central-1
    me-south-1
    sa-east-1
    us-gov-east-1
    us-gov-west-1
    ap-east-1

Brute-force S3 Buckets

    ffuf -u "https://hlogistics-ENVIRONMENT.s3.REGION.amazonaws.com" -w "regions.txt:REGION" -w "list.txt:ENVIRONMENT" -mc 200,403 -v 2>/dev/null

### 1) S3 Buckets

List S3 Buckets

    aws s3 ls BUCKET_NAME 

Recursive Listing

    aws s3 ls BUCKET_NAME --recursive

Download a file from an S3 bucket

    aws s3 cp s3://BUCKET_NAME/DIRECTORY/file.txt .

Reveal the S3 bucket region

    curl -I BUCKET_NAME.s3.amazonaws.com

## S3 API

Use --no-sign-request if querying a public S3 bucket (can be used for each command below)

### 1) Get bucket versioning

    aws s3api get-bucket-versioning --bucket BUCKET_NAME

### 2) List object versions

    aws s3api list-object-versions --bucket BUCKET_NAME --query "Versions[?VersionId!='null']"

### 3) Access on object

With versioning

    aws s3api get-object --bucket BUCKET_NAME --key "DIRECTORY/file.txt" --version-id "VERSION_ID" file.txt

Without versioning

    aws s3api get-object --bucket BUCKET_NAME --key "DIRECTORY/file.txt" file.txt

### 4) Check the bucket policy

    aws s3api get-bucket-policy --bucket BUCKET_NAME

## EC2

### 1) List active EC2 Instances

AWS CLI

    aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value | [0],InstanceId,Platform,State.Name,PrivateIpAddress,PublicIpAddress,InstanceType,PublicDnsName,KeyName]'

Pacu

    run ec2__enum

### 2) Retrieve the password of an EC2 instance

With key

    aws ec2 get-password-data --instance-id INSTANCE_ID --priv-launch-key KEY.pem

## Codecommit

### 1) Enumerate repositories

    aws codecommit list-repositories

### 2) Get details of a specific repository

    aws codecommit get-repository --repository-name REPOSITORY_NAME

### 3) List branches of a repository

    aws codecommit list-branches --repository-name REPOSITORY_NAME

### 4) Get branch details

    aws codecommit get-branch --repository-name REPOSITORY_NAME --branch-name BRANCH_NAME

### 5) Get commit details

    aws codecommit get-commit --repository-name REPOSITORY_NAME --COMMIT-ID commit_id

### 6) Find files that changed between commits

    aws codecommit get-differences --repository-name REPOSITORY_NAME --before-commit-specifier PARENT_COMMIT_ID --after-commit-specifier COMMIT_ID

### 7) Download a file from a repository based on a commit ID

    aws codecommit get-file --repository-name REPOSITORY_NAME --commit-specifier COMMIT_ID --file-path DIRECTORY/file.txt

Then decode the base64 file

    echo "BASE64" | base64 -d -w0
