# AWS EBS Enumeration

## Commands:

#### 1) Enumerating EBS volumes

    aws ec2 describe-volumes 

### If the volume is available, it can be attached to an EC2 instance

### Check if the EBS is encrypted

#### 2) Enumerating Snapshots

    aws ec2 describe-snapshots --owner-ids self 

### Also check if the snapshot is encrypted
