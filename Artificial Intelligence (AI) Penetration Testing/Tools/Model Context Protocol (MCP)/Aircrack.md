# Aircrack MCP

## Installation

### 1) Download project

    git clone https://github.com/techchipnet/aircrack-mcp
    cd aircrack-mcp
    chmod 777 aircrackmcp.py

### 2) Granting Passwordless Sudo Permissions

Open the sudoers file

    sudo visudo

Append the following at the bottom of the file:

    kali ALL=(ALL) NOPASSWD: /usr/bin/python3 /home/kali/aircrack-mcp/aircrackmcp.py

### 3) Configure Claude Desktop

Go to:

    Click on user profile -> Settings -> Developer Tab -> Edit Config

Add this in the mcpServers block

    {
        "mcpServers": {
            "aircrack": {
                "command": "sudo",
                "args": [
                "python3",
                "/home/kali/aircrack-mcp/aircrackmcp.py"
                ]
            }
        }
    }

Verify aircrack MCP installation by restarting, then checking in Claude.

## Execution

### 1) Discover available commands

    list aircrack mcp commands

### 2) Enumerating Wireless Interfaces

    list_interfaces

### 3) Enable Monitor Mode

    start_monitor

### 4) Scan for Wi-Fi networks

    scan all wifi

### 5) Capture the WPA2 handshake

    capture handshake SSID_NAME

### 6) Crack the handshake

    crack_wifi with dictionary rockyou.txt

### 7) Deauthentication attack

    deauth SSID_NAME
