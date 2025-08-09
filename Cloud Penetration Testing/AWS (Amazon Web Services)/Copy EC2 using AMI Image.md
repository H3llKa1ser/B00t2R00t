# AWS - Copy EC2 using AMI Image

#### 1) First you need to extract data about the current instances and their AMI/security groups/subnet :

    aws ec2 describe-images --region eu-west-1

#### 2) Create a new image for the instance-id

    aws ec2 create-image --instance-id i-0438b003d81cd7ec5 --name "AWS Audit" --description

#### 3) Add key to AWS

    aws ec2 import-key-pair --key-name "AWS Audit" --public-key-material file://~/.ssh/id_rsa.pub

#### 4) Create ec2 using the previously created AMI, use the same security group and subnet

    aws ec2 run-instances --image-id ami-0b77e2d906b00202d --security-group-ids "sg-6d0d7f01"

#### 5) Now you can check the instance

    aws ec2 describe-instances --instance-ids i-0546910a0c18725a1

#### 6) If needed: edit groups

    aws ec2 modify-instance-attribute --instance-id "i-0546910a0c18725a1" --groups "sg-6d0d7f01"

#### 7) Clean our instance to avoid any useless cost

    aws ec2 stop-instances --instance-id "i-0546910a0c18725a1" --region eu-west-1

    aws ec2 terminate-instances --instance-id "i-0546910a0c18725a1" --region eu-west-1
