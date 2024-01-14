# REQUIRED TOOL TO INTERACT WITH THE CLUSTER

## Download binary: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux

## Download: curl -LO https://github.com/cyberark/kubeletctl/releases/download/v1.7/kubeletctl_linux_amd64

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

## If the kubernetes services are exposed to the internet, and anonymous access is allowed, we can do:

#### 1) kubeletctl --server IP_ADDRESS pods (Enumerate the pods)

#### 2) kubeletctl --server IP_ADDRESS scan rce (Check for pods vulnerable to RCE)

#### 3) kubeletctl --server IP_ADDRESS exec "COMMAND" -p POD -c CONTAINER
