# Sliver client 

### 1) Download Sliver client

    wget -q https://github.com/BishopFox/sliver/releases/download/v1.5.42/sliver-client_linux
    chmod +x ./sliver-client_linux

### 2) Import the generated operator profile

    ./sliver-client_linux import /<path_to_generated_profile>/<operator_name>_<listening _IP>.cfg

### 3) Start the client

    ./sliver-client_linux 
