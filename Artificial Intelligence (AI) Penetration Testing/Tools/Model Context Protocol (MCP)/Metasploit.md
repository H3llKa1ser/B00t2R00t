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

## Metasploit Functionalities

Initial Access

### Review all Metasploit Toolset

    all commands

### 1) Initial Port Discovery

    scan IP

### 2) Full port scan

    complete port scan

### 3) Exploit a port/service

    exploit port NUM

OR

    run exploit on port NUM

Allow the task to be run by Claude

### 4) List active sessions

    list_active_sessions

### 5) List exploits for a specific service on a specific port

    list_exploit windows port NUM

Post Exploitation

### 1) List post-exploitation modules

    list post module

### 2) Enumerate SMB shares

    run_post_module_scanner/smb/smb_enumshares

Payload generation

### 1) Generate payload (Select the type of payload, then select output format, then generate)

    generate_payload
    Selection: exe

Interactively through the session, you will select the correct output format, listening IP and port

### 2) Start listener

    start_listener
