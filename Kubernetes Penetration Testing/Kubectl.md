# REQUIRED TOOL TO INTERACT WITH THE CLUSTER

## Download binary: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux

### We can:

#### Interact with the cluster using kubectl
#### Read Kubernetes secrets
#### Do recon inside the cluster
#### Switch service accounts to escalate your privileges
#### Lateral movement into other workloads
#### Gain access to the Kubernetes nodes

## Note: If the user is in the microk8s group, we can issue kubectl commands with the microk8s.kubectl or "k0s kubectl" pretext.

### Example commands:

#### 1) kubectl get pods

#### 2) kubectl -A get pods

#### 3) kubectl get deployments -o wide

#### 4) kubectl get services

#### 5) kubectl get rs (Replica sets)

#### 6) kubectl edit secret NAME

### For a detailed usage: we can do kubectl help or search online https://kubernetes.io/docs/reference/kubectl/
