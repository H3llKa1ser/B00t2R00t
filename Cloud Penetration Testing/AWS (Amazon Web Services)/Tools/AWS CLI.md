# Amazon Web Services (AWS) CLI Tool 

## Commands:

### Authentication

    aws configure (Set AWS programmatic keys for authentication (use --profile= for a new profile)

    aws configure set aws_session_token "SESSION_TOKEN" 

## (Use a session token with the Access Key and Secret Access Key (aws configure) to authenticate)

### Open S3 bucket enumeration

#### 1) List the contents of an S3 bucket

    aws s3 ls s3://BUCKET_NAME/ 

#### 2) Download contents of bucket

    aws s3 sync s3://BUCKET_NAME s3-files-dir 

### Account Information

#### 1) Get basic account info

    aws sts get-caller-identity 

#### 2) List IAM users

    aws iam list-users 

#### 3) List IAM roles

    aws iam list-roles 

#### 4) List S3 buckets accessible to an account

    aws s3 ls 

#### 5) Assume the role of a specific account

    aws sts assume-role --role-arn arn:aws:iam::AWS_ACCOUNT_ID:role/Administrator --role-session-name ROLE_NAME 

#### 6) List policies that are attached directly to our user

    aws iam list-attached-user-policies --user-name USER 

#### 7) See if a user is able to set their own AWS console password from the CLI

    aws iam update-login-profile --user-name USERNAME --password 'PASSWORD'
   
### Virtual Machines

#### 1) List EC2 instances

    aws ec2 describe-instances 

### Web Applications and SQL

#### 1) List webapps

    aws deploy list-applications 

#### 2) List AWS RDS (SQL)

    aws rds describe-db-instances --region REGION_NAME 

#### 3) Knowing the VPC Security Group ID you can query the firewall rules to determine connectivity potential

    aws ec2 describe-security-groups --group-ids VPC_SECURITY_GROUP_ID --region REGION 

### Serverless

#### 1) List Lambda functions

    aws lambda list-functions --region REGION 

#### 2) Look at environment variables set for secrets and analyze code

    aws lambda get-function --function-name LAMBDA_FUNCTION 

### Networking

#### 1) List EC2 subnets

    aws ec2 describe-subnets 

#### 2) List EC2 network interfaces

    aws ec2 describe-network-interfaces 

#### 3) List DirectConnect (VPN) connections

    aws directconnect describe-connections

### Identity Access Management IAM

#### 1) Update the "assume role" policy of a user using a .json file

    aws iam update-assume-role-policy --role-name ROLE_NAME --policy-document file://policy.json 

#### 2) List more information about a specific role 

    aws iam get-role --role-name ROLE_NAME 

#### 3) Enumerate IAM users and roles via S3 Bucket Policy

    aws s3api put-bucket-policy --bucket iam-enum --policy file://s3_policy.json 

#### 4) Enumerate IAM users and roles via lambda functions

    aws lambda add-permission --function-name FUNCTION_NAME --action lambda:GetFunction --statement-id IAMEnum --principal "arn:aws:iam::AWS_ACCOUNT_ID:role/admin" 

### SecretsManager and SSM (AWS System Manager)

#### 1) Get secret

    aws secretsmanager get-secret-value --secret-id ID --region REGION

#### 2) 

    aws ssm get-parameter --name "/application/APP/NAME/USER_OR_PASS" --with-decryption --region REGION 

### AWS API Gateway

#### 1) List APIs

    aws apigateway get-rest-apis 

#### 2) Deploy an existing API to a specific stage

    aws apigateway create-deployment --rest-api-id API_ID --stage-name STAGE_NAME(API/PROD/ETC) 

#### 3) Update the API settings/policies/etc.

    aws apigateway update-rest-api --rest-api-id API_ID --patch-operations JSON_API_DATA 

### Batch Operations

#### 1) View the current status of the latest job

    aws s3control list-jobs --account-id AWS_ACCOUNT_ID | less 

#### 2) Create a batch operation job

    aws s3control create-job --account-id AWS_ACCOUNT_ID --operation '{"S3ReplicationObject":{}}' --report '{"Bucket":"arn:aws:s3:::BUCKET_NAME","Prefix":"batch-replication-report","Format":"Report_CSV_20180820","Enabled":true,"ReportScope":"AllTasks"}' --manifest-generator '{"S3JobManifestGenerator":{"ExpectedBucketOwner":"AWS_ACCOUNT_ID","SourceBucket":"arn:aws:s3:::BUCKET_NAME","EnableManifestOutput":false,"Filter":{"EligibleForReplication":true,"ObjectReplicationStatuses": ["NONE","FAILED","COMPLETED","REPLICA"]}}}' --priority 1 --role-arn "arn:Aws:iam:AWS_ACCOUNT_ID:role/ROLE_NAME" --no-confirmation-required --region REGION --description "WHATEVER" 
 

