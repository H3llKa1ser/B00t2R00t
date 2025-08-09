# AWS S3 Enumeration

## Commands:

#### 1) Listing all buckets in AWS account

    aws s3api list-buckets 

#### 2) Getting information about a specific bucket

    aws s3api get-bucket-acl --bucket BUCKET_NAME 

#### 3) Getting information about a specific bucket policy

    aws s3api get-bucket-policy --bucket BUCKET_NAME 

#### 4) Getting the Public Access Block configuration for an S3 bucket

    aws s3api get-public-access-block --bucket BUCKET_NAME 

#### 5) Listing all objects in a specific bucket

    aws s3api list-objects --bucket BUCKET_NAME 

#### 6) Getting ACL information about a specific object

    aws s3api get-object-acl --bucket-name BUCKET_NAME --key OBJECT_NAME 
