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

