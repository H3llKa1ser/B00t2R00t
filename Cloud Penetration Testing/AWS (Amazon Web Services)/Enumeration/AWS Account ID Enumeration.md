# AWS Account ID Enumeration

## Tool: s3-account-search

### Commands

 - s3-account-search ARN_OF_THE_ROLE S3_BUCKET_NAME (Reveals the AWS Account ID)

 - curl -I https://BUCKET_NAME.s3.amazonaws.com (Use this to find the S3 Bucket region)

## TIP: We can use this information to hunt down public resources that might have been accidently exposed by the account owner, such as public EBS and RDS snapshots.

