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

