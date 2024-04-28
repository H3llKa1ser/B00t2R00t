# AWS EC2 Enumeration

## Commands:

 - aws ec2 describe-instances (Listing information about all instances)

 - aws ec2 describe-instances --region REGION (Listing information about a specific region)

 - aws ec2 describe-instances --instance-ids ID (Listing information about specific instance)

## This command gathers the metadata from the instance, like commands or secrets. The output is base64 encoded:

 - aws ec2 describe-instance-attribute --attribute userData --instance-id INSTANCE_ID (Extracting UserData attribute of specified instance)

 - aws ec2 describe-iam-instance-profile-associations (Listing roles of an instance)
