# Kubernetes Enumeration

## TOOL: Kubectl

#### 1) Check if your current account has privileges to create pods to any namespaces

    kubectl auth can-i create pods --all-namespaces 

#### 2) Check what your current user can do within the cluster

    kubectl auth can-i --list 

#### 3) Enumerate namespaces (use -n NAMESPACE flag after typing this command to check more details about the specific namespace)

    kubectl get namespaces 

#### 4) Check the pods in a specified namespace

    kubectl get pods -n NAMESPACE 

#### 5) Check details about a specific pod in a specific namespace

    kubectl describe pod POD -n NAMESPACE 

## TIP: kube-system namespace has the top privileges inside the cluster, so if in any way we can interact with it, it's a good sign we can compromise the entire cluster
