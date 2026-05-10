# Valid Credentials

## Authenticate

Sign-in URL for IAM users on AWS Console

https://AWS_ACCOUNT_ID.signin.aws.amazon.com/console

Tools: 

1) Pacu https://github.com/RhinoSecurityLabs/pacu

2) aws-enumerator https://github.com/shabarkin/aws-enumerator

### 1) Set the access key, access key ID and region name

AWS CLI

    aws configure

Set session token

    aws configure set aws_session_token "TOKEN"

Pacu framework

    ./cli.py
    set_keys    

aws-enumerator 

    aws-enumerator cred -aws_access_key_id 'AKIA......' -aws_secret_access_key 'SECRET_ACCESS_KEY' -aws_region REGION

### 2) Verify identity (like whoami)

    aws sts get-caller-identity

### 4) Situational Awareness 

Pacu

    run iam__bruteforce_permissions

aws-enumerator

    aws-enumerator enum --services all

## IAM

### 1) Users

List users

    aws iam list-users

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

List roles

    aws iam list-roles

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

## Security Token Service (STS)

### 1) Check in which AWS account an access key belongs to

    aws sts get-access-key-info --access-key-id AKIA........

### 2) Assume role

    aws sts assume-role --role-arn arn:aws:iam::AWS_ACCOUNT_ID:role/ROLE_NAME --role-session-name ROLE_NAME

Use an external ID to assume a role

    aws sts assume-role --role-arn arn:aws:iam::AWS_ACCOUNT_ID:role/ROLE_NAME --role-session-name ROLE_NAME --external-id EXTERNAL_ID

## EC2

### 1) List active EC2 Instances

AWS CLI

    aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value | [0],InstanceId,Platform,State.Name,PrivateIpAddress,PublicIpAddress,InstanceType,PublicDnsName,KeyName]'

Pacu

    run ec2__enum

### 2) Retrieve the password of an EC2 instance

With key

    aws ec2 get-password-data --instance-id INSTANCE_ID --priv-launch-key KEY.pem

### 3) List all available EC2 launch templates

    aws ec2 describe-launch-templates

### 4) Check if a launch template has any user data defined

    aws ec2 describe-launch-template-versions --launch-template-name LAUNCH_TEMPLATE_NAME --query "LaunchTemplateVersions[0].LaunchTemplateData.UserData" --output text | base64 --decode

### 5) Describe EBS snapshots

    aws ec2 describe-snapshots --owner-ids AWS_ACCOUNT_ID --region REGION

Enumerate public snapshots

    aws ec2 describe-snapshots --owner-id self --restorable-by-user-ids all --no-paginate --region us-east-1

### 6) Describe a specific snapshot attribute

    aws ec2 describe-snapshot-attribute --attribute createVolumePermission --snapshot-id snap-ID --region REGION

### 7) Describe EC2 Instance Attribute UserData

    aws ec2 describe-instance-attribute --instance-id i-INSTANCE_ID --attribute userData --query 'UserData.Value' --output text | base64 --decode

### 8) Check if you can reboot an EC2 instance

Remove --dry-run to reboot the instance if you have permissions.

    aws ec2 reboot-instances --instance-ids i-INSTANCE_ID --dry-run

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

## Systems Manager (SSM)

### 1) Retrieve parameter

    aws ssm get-parameter --name PARAMETER_NAME

## Cognito

Use --no-sign for unauthenticated access.

### 1) Identity Pools

Get an Identity ID from an Identity pool

    aws cognito-identity get-id --identity-pool-id IDENTITY_POOL_ID

Get an identity ID by copying the access token from IdToken and specifying the user pool ID

    aws cognito-identity get-id --identity-pool-id IDENTITY_POOL_ID --logins "{ \"cognito-idp.us-east-1.amazonaws.com/us-east-1_8rcK7abtz\": \"<JWT_TOKEN>\" }"

Request credentials for an Identity ID

    aws cognito-identity get-credentials-for-identity --identity-id IDENTITY_ID --no-sign

Request credentials with unique identifiers

    aws cognito-identity get-credentials-for-identity --identity-id IDENTITY_POOL_ID --logins "{ \"cognito-idp.us-east-1.amazonaws.com/us-east-1_8rcK7abtz\": \"<JWT_TOKEN>\" }"

### 2) User Pools

Sign up an account

    aws cognito-idp sign-up --client-id CLIENT_ID --username USERNAME --password 'PASSWORD'

Send confirmation code

    aws cognito-idp sign-up --client-id CLIENT_ID --username USERNAME --password PASSWORD --user-attributes Name="email",Value="EMAIL@mail.com" Name="name",Value="Test"

Confirm sign up

    aws cognito-idp confirm-sign-up --client-id CLIENT_ID --username USERNAME --confirmation-code CONFIRMATION_CODE

Initiate authentication to print a JWT token

    aws cognito-idp initiate-auth --client-id CLIENT_ID --auth-flow USER_PASSWORD_AUTH --auth-parameters USERNAME=USER,PASSWORD=P@SSW0RD

## Lambda

### 1) List Lambda functions

    aws lambda list-functions

### 2) Enumerate a specific Lambda function

    aws lambda get-function --function-name LAMBDA_FUNCTION_NAME

### 3) Invoke Lambda function

    aws lambda invoke --function-name LAMBDA_FUNCTION_NAME response.json

Send a specific payload upon invoking the Lambda function

    aws lambda invoke --function-name LAMBDA_FUNCTION_NAME --payload '{ "target": "http://example.com" }' response.json

Base64 encode the payload

    aws lambda invoke --cli-binary-format raw-in-base64-out --function-name LAMBDA_FUNCTION_NAME --payload '{ "target": "http://example.com" }' response.json

## Secrets Manager

### 1) List secrets

    aws secretsmanager list-secrets --query 'SecretList[*].[Name, Description, ARN]' --output json

### 2) Get secret value

    aws secretsmanager get-secret-value --secret-id SECRET_NAME

## CloudShell

### 1) Get temporary credentials

    TOKEN=$(curl -X PUT localhost:1338/latest/api/token -H "X-aws-ec2-metadata-token-ttl-seconds: 60")
    curl localhost:1338/latest/meta-data/container/security-credentials -H "X-aws-ec2-metadata-token: $TOKEN"

## RDS

### 1) Look for public snapshots from single RDS database instances that belong to an AWS Account ID

    aws rds describe-db-snapshots --snapshot-type public --include-public --region us-east-1 | grep AWS_ACCOUNT_ID

### 2) Look for public snapshots from RDS database cluster instances

    aws rds describe-db-cluster-snapshots --snapshot-type public --include-public --region us-east-1 | grep AWS_ACCOUNT_ID

## SQS 

### 1) List queues

    aws sqs list-queues

### 2) Receive a message from the queue

    aws sqs receive-message --queue-url https://eu-north-1.queue.amazonaws.com/AWS_ACCOUNT_ID/NAME --message-attribute-names All

### 3) Send a message to a queue

Example payload

    aws sqs send-message --queue-url https://eu-north-1.queue.amazonaws.com/AWS_ACCOUNT_ID/NAME --message-attributes '{ "Weight": { "StringValue": "1337", "DataType":"Number"}, "Client": {"StringValue":"VELUS CORP.", "DataType": "String"}, "trackingID": {"StringValue":"HLT1337", "DataType":"String"}}' --message-body "Testing"

## SNS

### 1) List topics

    aws sns list-topics

### 2) Create a new SNS topic

    aws sns create-topic --name TOPIC_NAME

### 3) Subscribe to an SNS topic

Check your email inbox later to confirm the subscription.

    aws sns subscribe --topic-arn arn:aws:sns:us-west-2:AWS_ACCOUNT_ID:TOPIC_NAME --protocol email --notification-endpoint sns.mail@email.com

