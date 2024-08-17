## Check our permissions to see if we can list and get secrets in this namespace

#### 1) kubectl auth can-i --list

#### 2) kubectl get secrets

#### 3) kubectl describe secret SECRET

#### 4) kubectl get secret SECRET -o jsonpath='{.data}'
