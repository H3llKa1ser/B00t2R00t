# AWS - Instance Connect - Push an SSH key to EC2 instance

 - aws ec2 describe-instances --profile uploadcreds --region eu-west-1 | jq ".[][].Instances

 - aws ec2-instance-connect send-ssh-public-key --region us-east-1 --instance-id INSTANCE
