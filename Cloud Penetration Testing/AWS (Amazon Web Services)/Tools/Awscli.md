# Amazon Web Services (AWS) CLI Tool 

## Commands:

### Authentication

 - aws configure (Set AWS programmatic keys for authentication (use --profile= for a new profile)

### Open S3 bucket enumeration

 - aws s3 ls s3://BUCKET_NAME/ (List the contents of an S3 bucket)

 - aws s3 sync s3://BUCKET_NAME s3-files-dir (Download contents of bucket)

### Account Information

 - aws sts get-caller-identity (Get basic account info)

 - aws iam list-users (List IAM users)

 - aws iam list-roles (List IAM roles)

 - aws s3 ls (List S3 buckets accessible to an account

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
