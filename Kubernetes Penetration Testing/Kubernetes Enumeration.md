## TOOL: KUBECTL

#### 1) kubectl auth can-i create pods --all-namespaces (Check if your current account has privileges to create pods to any namespaces)

#### 2) kubectl auth can-i --list (Check what your current user can do within the cluster)

#### 3) kubectl get namespaces (Enumerate namespaces) (use -n NAMESPACE flag after typing this command to check more details abou the specific namespace)

#### 4) kubectl get pods -n NAMESPACE (Check the pods in a specified namespace) 

#### 5) kubectl describe pod POD -n NAMESPACE (Check details about a specific pod in a specific namespace)

## TIP: kube-system namespace has the top privileges inside the cluster, so if in any way we can interact with it, it's a good sign we can compromise the entire cluster
