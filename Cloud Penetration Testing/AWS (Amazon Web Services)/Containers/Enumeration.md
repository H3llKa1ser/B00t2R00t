# Enumeration

## ECR

 - aws ecr describe-repositories (Listing all repositories in container registry)

 - aws ecr get-repository-policy --repository-name NAME (Listing information about repository policy)

 - aws ecr list-images --repository-name NAME (Listing all images in a specific repository)

 - aws ecr describe-images --repository-name NAME --images-ids imageTag=NAME (Listing information about an image)

## ECS

 - aws ecs list-clusters (Listing all ECS clusters)

 - aws ecs describe-clusters --cluster NAME (Listing information about an specific cluster)

 - aws ecs list-services --cluster NAME (Listing all services in specified cluster)

 - aws ecs descibe-services --cluster NAME --services NAME (Listing information about an specific service) (This command shows the logs of the service)

 - aws ecs list-tasks --cluster NAME (Listing tasks in specific cluster)

 - aws ecs describe-tasks --cluster NAME -tasks TASK_ARN (Listing information about a specific task)

## TIP: Also shows information about network, useful if trying to pivot.

 - aws ecs list-container-instances --cluster NAME (Listing all containers in specified cluster)

# EKS

 - aws eks list-clusters (Listing all EKS clusters)

 - aws eks describe-cluster --name NAME (Listing information about a specific cluster)

 - aws eks list-nodegroups --cluster-name NAME (Listing all node groups in specified cluster)

 - aws eks describe-nodegroup --cluster-name NAME --nodegroup-name NAME (Listing specific information about a node group in a cluster)

 - aws eks list-fargate-profiles --cluster-name CLUSTER_NAME (Listing Fargate in specified cluster)

 - aws eks describe-fargate-profiles --cluster-name NAME --fargate-profile-name NAME (Listing information about a fargate profile in a cluster)
