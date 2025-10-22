# Sliver server installation

### 1) Install binary

    wget -q https://github.com/BishopFox/sliver/releases/download/v1.5.42/sliver-server_linux
    chmod +x ./sliver-server_linux
    ./sliver-server_linux

### 2) Operator profile

    [server] sliver > new-operator -n OPERATOR_NAME -l LISTENING_IP

### 3) Multiplayer mode

    [server] sliver > multiplayer
