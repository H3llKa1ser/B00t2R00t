# Amazon Web Services (AWS) CLI Tool 

## Commands:

### Authentication

 - aws configure (Set AWS programmatic keys for authentication (use --profile= for a new profile)

 - aws configure set aws_session_token "SESSION_TOKEN" (Use a session token with the Access Key and Secret Access Key (aws configure) to authenticate)

### Open S3 bucket enumeration

 - aws s3 ls s3://BUCKET_NAME/ (List the contents of an S3 bucket)

 - aws s3 sync s3://BUCKET_NAME s3-files-dir (Download contents of bucket)

### Account Information

 - aws sts get-caller-identity (Get basic account info)

 - aws iam list-users (List IAM users)

 - aws iam list-roles (List IAM roles)

 - aws s3 ls (List S3 buckets accessible to an account)

 - aws sts assume-role --role-arn arn:aws:iam::AWS_ACCOUNT_ID:role/Administrator --role-session-name ROLE_NAME (Assume the role of a specific account)

 - aws iam list-attached-user-policies --user-name USER (List policies that are attached directly to our user)

### Virtual Machines

 - aws ec2 describe-instances (List EC2 instances)

### Web Applications and SQL

 - aws deploy list-applications (List webapps)

 - aws rds describe-db-instances --region REGION_NAME (List AWS RDS (SQL))

 - aws ec2 describe-security-groups --group-ids VPC_SECURITY_GROUP_ID --region REGION (Knowing the VPC Security Group ID you can query the firewall rules to determine connectivity potential)

### Serverless

 - aws lambda list-functions --region REGION (List Lamda functions)

 - aws lambda get-function --function-name LAMBDA_FUNCTION (Look at environment variables set for secrets and analyze code)

### Networking

 - aws ec2 describe-subnets (List EC2 subnets)

 - aws ec2 describe-network-interfaces (List EC2 network interfaces)

 - aws directconnect describe-connections (List DirectConnect (VPN) connections)

### Identity Access Management IAM

 - aws iam update-assume-role-policy --role-name ROLE_NAME --policy-document file://policy.json (Update the "assume role" policy of a user using a .json file)

 - aws iam get-role --role-name ROLE_NAME (List more information about a specific role)

 - aws s3api put-bucket-policy --bucket iam-enum --policy file://s3_policy.json (Enumerate IAM users and roles via S3 Bucket Policy)

 - aws lambda add-permission --function-name FUNCTION_NAME --action lambda:GetFunction --statement-id IAMEnum --principal "arn:aws:iam::AWS_ACCOUNT_ID:role/admin" (Enumerate IAM users and roles via lambda functions)


