# Enumeration

## ECR

#### 1) Listing all repositories in container registry

    aws ecr describe-repositories

#### 2) Listing information about repository policy

    aws ecr get-repository-policy --repository-name NAME 

#### 3) Listing all images in a specific repository

    aws ecr list-images --repository-name NAME 

#### 4) Listing information about an image

    aws ecr describe-images --repository-name NAME --images-ids imageTag=NAME 

## ECS

#### 1) Listing all ECS clusters

    aws ecs list-clusters 

#### 2) Listing information about an specific cluster

    aws ecs describe-clusters --cluster NAME 

#### 3) Listing all services in specified cluster

    aws ecs list-services --cluster NAME 

#### 4) Listing information about a specific service (This command shows the logs of the service)

    aws ecs descibe-services --cluster NAME --services NAME 

#### 5) Listing tasks in specific cluster

    aws ecs list-tasks --cluster NAME 

#### 6) Listing information about a specific task

    aws ecs describe-tasks --cluster NAME -tasks TASK_ARN 

## TIP: Also shows information about network, useful if trying to pivot.

#### 7) Listing all containers in specified cluster

    aws ecs list-container-instances --cluster NAME 

# EKS

#### 1) Listing all EKS clusters

    aws eks list-clusters 

#### 2) Listing information about a specific cluster

    aws eks describe-cluster --name NAME

#### 3) Listing all node groups in specified cluster
   
    aws eks list-nodegroups --cluster-name NAME 

#### 4) Listing specific information about a node group in a cluster

    aws eks describe-nodegroup --cluster-name NAME --nodegroup-name NAME 

#### 5) Listing Fargate in specified cluster

    aws eks list-fargate-profiles --cluster-name CLUSTER_NAME 

#### 6) Listing information about a fargate profile in a cluster

    aws eks describe-fargate-profiles --cluster-name NAME --fargate-profile-name NAME 
