# AWS EC2 Enumeration

## Commands:

#### 1) Listing information about all instances

    aws ec2 describe-instances

#### 2) Listing information about a specific region
   
    aws ec2 describe-instances --region REGION 

#### 3) Listing information about specific instance

    aws ec2 describe-instances --instance-ids ID 

## This command gathers the metadata from the instance, like commands or secrets. The output is base64 encoded:

#### 4) Extracting UserData attribute of specified instance

    aws ec2 describe-instance-attribute --attribute userData --instance-id INSTANCE_ID 

#### 5) Listing roles of an instance

    aws ec2 describe-iam-instance-profile-associations 
