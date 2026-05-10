# Kubernetes

## Tools

Link: https://kubernetes.io/docs/tasks/tools/

1) Kubectl

You can find credentials and endpoints as environmental variables in the file

    .env

## Kubernetes RBAC

### 1) Check what Kubernetes API actions our compromised identity/user can perform

    kubectl auth can-i --list

### 2) Check what actions our compromised identity/user can do in a specific namespace

    kubectl auth can-i --list -n NAMESPACE_NAME

## Namespaces

### 1) Enumerate namespaces

    kubectl get namespaces

## Pods

### 1) Enumerate pods across all namespaces

    kubectl get pods -A

### 2) Enumerate existing workloads in a specific namespace 

    kubectl get pod POD_NAME -n NAMESPACE_NAME -o yaml

### 3) Execute commands within a pod

    kubectl exec -n POD_NAME -- aws iam list-roles

## Service Accounts

### 1) Enumerate service accounts across all namespaces

    kubectl get sa -A

### 2) Inspect a specific service account in a specific namespace

    kubectl describe sa SERVICE_ACCOUNT_NAME-sa -n NAMESPACE_NAME

## Secrets

### 1) List secrets 

    kubectl get secrets

### 2) View secret contents

    kubectl get secret SECRET_NAME -o jsonpath='{.data}'
