# AWS VPC Enumeration

## Commands:

 - aws ec2 describe-vpcs (Listing VPCs)

 - aws ec2 describe-vpcs --region us-west-1 (Listing VPCs specifying the region)

 - aws ec2 describe-vpcs --filters "Name=VPC-ID,Values=ID" (Listing VPC information by ID)

 - aws ec2 describe subnets (Listing subnets)

 - aws ec2 describe-subnets --filters "Name=VPC-ID,Values=ID" (Listing subnets by VPC-ID)

 - aws ec2 describe-route-tables (Listing routing tables)

 - aws ec2 describe-route-tables --filters "Name=VPC-ID,Values=ID" (Listing routing tables by VPC-ID)

 - aws ec2 desribe-network-acls (Listing Network ACLs)
