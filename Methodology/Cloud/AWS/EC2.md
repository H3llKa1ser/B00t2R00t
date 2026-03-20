# EC2

## Connect to instances

### Methods to connect

| Method               | Requires Direct Network Access | Requires Agent                               | Requires EC2 IAM Permissions |
|----------------------|--------------------------------|----------------------------------------------|------------------------------|
| **Direct SSH/RDP**   | YES                            | NO                                           | NO                           |
| **EC2 Instance Connect** | YES                        | YES (Installed on Amazon Linux 2)            | NO                           |
| **SSM Run Command**  | NO                             | YES                                          | YES                          |
| **SSM Session Manager** | NO                          | YES                                          | YES                          |
| **EC2 Serial Console**  | NO                          | NO, but users must have a password set       | NO                           |

### 1) In AWS Console, go to:

Ec2 Instance Connect

    EC2 -> Instance ID -> Connect -> EC2 Instance Connect -> Chose Public OR Private IP -> Connect

SSM Session Manager

    EC2 -> Instance ID -> SSM Session Manager -> Connect

## Instance Metadata Service (IMDS)

#### IMDSv1

### 1) Get the role name (EC2 Instance Shell)

    role_name=$( curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/ )
    echo "Role Name is $role_name"

## 2) Ask for session credentials

    curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${role_name}

#### IMDSv2

