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

### 4) Integrate MCP

In Claude Desktop, go to:

    Settings -> Developer tab -> Local MCP Servers -> Edit Config to open the JSON file that defines them.

Claude configuration file

    ~/.config/Claude/claude_desktop_config.json

Review default configuration, then add an mcpServers block alongside these settings

    {
        "preferences": {
            "coworkWebSearchEnabled": true,
            "remoteToolsDeviceName": "kali",
            "coworkScheduledTasksEnabled": true,
            "ccdScheduledTasksEnabled": true,
            "sidebarMode": "epitaxy",
            "bypassPermissionsGateByAccount": {
                "UUID_HERE": false
            },
            "epitaxyPrefs": {
                "starred-local-code-sessions": [],
                "starred-cowork-spaces": [],
                "starred-session-groups": []
            }
        },
        "coworkUsersFilesPath": "/home/kali/Claude"
    }


Reference the MetasploitMCP Template

Link: 

    https://mcpservers.org/servers/fishke22/MetasploitMCP

Register the Metasploit Server

From the link, take the mcpServers block, then change the corresponding fields:

    "command": "metasploitmcp"
    "--transport":,
    "stdio"
    "MSF_PASSWORD": "YOUR_PASS_HERE"

Confirm the server is running.
