# Kubectl-Kubeletctl

## Download binary: 

https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux

## Download: 

    curl -LO https://github.com/cyberark/kubeletctl/releases/download/v1.7/kubeletctl_linux_amd64

### We can:

#### 1) Interact with the cluster using kubectl

#### 2) Read Kubernetes secrets

#### 3) Do recon inside the cluster

#### 4) Switch service accounts to escalate your privileges

#### 5) Lateral movement into other workloads

#### 6) Gain access to the Kubernetes nodes

## Note: If the user is in the microk8s group, we can issue kubectl commands with the microk8s.kubectl or "k0s kubectl" pretext.

Example commands:

### 1) Enumerate pods

    kubectl get pods

### 2) Enumerate pods in the entire cluster

    kubectl -A get pods

### 3) Enumerate deployments

    kubectl get deployments -o wide

### 4) Enumerate services

    kubectl get services

### 5) Replica Sets

    kubectl get rs 

### 6) Edit secret

    kubectl edit secret NAME

### 7) See secret in a specific namespace

    kubectl get secret SECRET -n NAMESPACE 

#### For a detailed usage: we can do kubectl help or search online https://kubernetes.io/docs/reference/kubectl/

If the kubernetes services are exposed to the internet, and anonymous access is allowed, we can do:

### 1) Enumerate the pods

    kubeletctl --server IP_ADDRESS pods 

### 2) Check for pods vulnerable to RCE

    kubeletctl --server IP_ADDRESS scan rce 

### 3) Execute command on a container

    kubeletctl --server IP_ADDRESS exec "COMMAND" -p POD -c CONTAINER
