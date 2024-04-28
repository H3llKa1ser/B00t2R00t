# AWS VPC Lateral Movement and Pivoting

### We can abuse VPC peering to do lateral movement

## Scenario:

### There are 3 VPC's -> A,B,C

### A can access B through peering and B access C. We can use VPC B as a peering pivot to access VPC C from VPC A.

### The lateral movement can be done if we gather keys or other machines

### Always enumerate the subnets to see in which subnet we can access other VPC's

## Steps:

#### 1) Listing VPC peering connections

 - aws ec2 describe-vpc-peering-connections

#### 2) Listing subnets of specific VPC (Important because the access can be restricted to specific subnets to other VPC's)

 - aws ec2 describe-subnets --filters "Name=VPC-ID,Values=ID"

#### 3) Listing routing tables

 - aws ec2 describe-route-tables --filters "Name=VPC-ID,Values=ID"

#### 4) Listing instances on the specified VPC ID

 - aws ec2 describe-instances --filters "Name=VPC-ID,Values=ID"

#### 5) Listing instances on the specified subnet

 - aws ec2 describe-instances --filters "Name=SUBNET-ID,Values=ID"
