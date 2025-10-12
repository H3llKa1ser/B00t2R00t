# Reconnaissance

#### 1) Understanding your EKS environment - The reconnaissance phase

    aws eks list-clusters --region us-west-2

    aws eks describe-cluster --name production-cluster --region us-west-2

    kubectl get nodes -o wide

    kubectl get pods --all-namespaces
