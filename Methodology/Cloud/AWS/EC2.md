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

### 1) Enable IMDSv2

Get the instance ID

    instance_id=$( curl -s http://169.254.169.254/latest/meta-data/instance-id )
    echo "My Instance ID is $instance_id"

Update the instance metadata options to require a token to make the instance metadata call

    aws ec2 modify-instance-metadata-options --instance-id $instance_id --http-tokens required --region us-east-1

### 2) Get the HTTP Token

    TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
    echo $TOKEN

### 3) Get credentials

    role_name=$( curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/iam/security-credentials/ )
    echo "Role Name is $role_name"
    curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/iam/security-credentials/${role_name}

## EC2 Networking

### 1) Look for network information

AWS CLI or CloudShell: https://console.aws.amazon.com/cloudshell/home?region=us-east-1

    aws ec2 describe-network-interfaces | jq '.NetworkInterfaces[0]'

## EC2 Storage

### 1) Check information on a snapshot

AWS CLI or CloudShell

    aws ec2 describe-snapshots --snapshot-ids snap-SNAPSHOT_ID

### 2) Get the availability zone

EC2 Instance Console

    TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
    curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone

### 3) Create a volume from the snapshot

EC2 Instance Console

    aws ec2 create-volume --snapshot-id snap-SNAPSHOT_ID --volume-type gp3 --region us-east-1 --availability-zone AVAILABILITY_ZONE

### 4) Attach the volume to our instance

EC2 Instance Console

    instance_id=$( curl  -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-id )
    aws ec2 attach-volume --region us-east-1 --device /dev/sdh --instance-id $instance_id --volume-id vol-VOLUME_ID_FROM_PREVIOUS_COMMAND

### 5) Check the existance of the volume

EC2 Instance Console

    sudo fdisk -l

### 6) Create a mount point, mount the disk and view contents

    sudo mkdir /whatever
    sudo mount /dev/nvme1n1 /whatever
    ls /whatever
    cat /whatever/root/root.txt

## EC2 Configuration

#### UserData file

EC2 Instance Console

### 1) Read the data from the UserData file

    TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    instance_id=$( curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-id )
    aws ec2 describe-instance-attribute --attribute userData --instance-id $instance_id --region us-east-1 --query UserData --output text  | base64 -d

OR 

    sudo nano /var/lib/cloud/instance/scripts/part-001
