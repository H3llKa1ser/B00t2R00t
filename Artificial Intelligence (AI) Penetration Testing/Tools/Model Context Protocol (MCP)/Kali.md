# Kali MCP

## Installation

### 1) Install Kali MCP

    sudo apt install mcp-kali-server

### 2) Start the Kali MCP/API Server

    kali-server mcp

Review client configuration

Link:

    https://github.com/Wh0am123/MCP-Kali-Server

### 3) Add Claude Desktop repository key and install it

Import the repository signing key so APT can verify packages

    curl -fsSL https://pkg.claude-desktop-debian.dev/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/claude-desktop.gpg

Register the repository and refresh APT

    echo "deb [signed=/usr/share/keyrings/claude-desktop.gpg arch=amd64,arm64] https://pkg.claude-desktop-debian.dev stable main" | sudo tee /etc/apt/sources.list.d/claude-desktop.list

Install Claude Desktop

    sudo apt install claude-desktop

