# AWS EBS Enumeration

## Commands:

 - aws ec2 describe-volumes (Enumerating EBS volumes)

### If the volume is available, it can be attached to an EC2 instance

### Check if the EBS is encrypted

 - aws ec2 describe-snapshots --owner-ids self (Enumerating Snapshots)

### Also check if the snapshot is encrypted
