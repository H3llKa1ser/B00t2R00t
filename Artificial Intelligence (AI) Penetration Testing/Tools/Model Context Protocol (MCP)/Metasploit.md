# Metasploit MCP

## Installation

### 1) Use apt package manager

    sudo apt install metasploitmcp

### 2) Start PostgreSQL and the MSF RPC Daemon

PostgreSQL

    sudo service postgresql start

MSF RPC Daemon

    msfrpcd -P MSF_PASSWORD -S -a 127.0.0.1 -p 55553

### 3) Add Claude Desktop repository key and install it

Import the repository signing key so APT can verify packages

    curl -fsSL https://pkg.claude-desktop-debian.dev/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/claude-desktop.gpg

Register the repository and refresh APT

    echo "deb [signed=/usr/share/keyrings/claude-desktop.gpg arch=amd64,arm64] https://pkg.claude-desktop-debian.dev stable main" | sudo tee /etc/apt/sources.list.d/claude-desktop.list

Install Claude Desktop

    sudo apt install claude-desktop

