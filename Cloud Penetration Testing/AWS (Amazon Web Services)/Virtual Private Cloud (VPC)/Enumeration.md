# AWS VPC Enumeration

## Commands:

#### 1) Listing VPCs

    aws ec2 describe-vpcs 

#### 2) Listing VPCs specifying the region

    aws ec2 describe-vpcs --region us-west-1 

#### 3) Listing VPC information by ID

    aws ec2 describe-vpcs --filters "Name=VPC-ID,Values=ID" 

#### 4) Listing subnets

    aws ec2 describe subnets 

#### 5) Listing subnets by VPC-ID

    aws ec2 describe-subnets --filters "Name=VPC-ID,Values=ID" 

#### 6) Listing routing tables

    aws ec2 describe-route-tables 

#### 7) Listing routing tables by VPC-ID

    aws ec2 describe-route-tables --filters "Name=VPC-ID,Values=ID" 

#### 8) Listing Network ACLs

    aws ec2 describe-network-acls 
