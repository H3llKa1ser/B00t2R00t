# Hexstrike

Link: https://www.hexstrike.com/

## Specs

    Kali Linux 2023.1+, Python 3.8+, 4GB RAM minimum (8GB recommended), 20GB free storage. 

## Installation

### 1) Apt

    sudo apt install hexstrike-ai

### 2) From source

    git clone https://github.com/0x4m4/hexstrike-ai.git
    cd hexstrike-ai
    pip3 install -r requirements.txt

## Execution

### 1) Start the API Server

    hexstrike_server --port 8888
    # or with debug output:
    hexstrike_server --port 8888 --debug

The server binds to 127.0.0.1:8888 by default and spins up 4 process pool workers.

### 2) Start the MCP bridge

    hexstrike_mcp --server http://127.0.0.1:8888
    # optional flags:
    # --timeout 300   (default, seconds)
    # --debug         verbose logging

# Connection to Claude Desktop

#### ~/.config/Claude/claude_desktop_config.json

    {
      "mcpServers": {
        "hexstrike": {
          "command": "hexstrike_mcp",
          "args": ["--server", "http://127.0.0.1:8888"]
        }
      }
    }

Restart Claude Desktop after saving.

## Tool Categories

The integrated toolset covers:

- **Network & Recon:** nmap, masscan, rustscan, amass, subfinder, nuclei, autorecon, netexec, enum4linux-ng
- **Web:** gobuster, feroxbuster, ffuf, sqlmap, wpscan, dalfox, wafw00f, nikto, httpx
- **Password/Auth:** hydra, john, hashcat, crackmapexec, evil-winrm, medusa
- **Binary/RE:** gdb, radare2, binwalk, ghidra, checksec, volatility3, steghide
- **Cloud:** prowler, trivy, scout-suite, kube-hunter, kube-bench 

---

## Usage Examples

Once your AI client is connected, you drive everything via prompts:

    "Run a full port scan on 10.10.10.5"
    "Enumerate subdomains for target.com using subfinder and amass"
    "Check for SQLi on http://target.htb/login"
    "Crack this hash: 5f4dcc3b5aa765d61d8327deb882cf99"
    "Run autorecon against 10.10.10.5"

## SSH Tunnel

### 1) On main OS — create tunnel

    ssh -L 8888:localhost:8888 user@KALI_IP

### 2) On Kali — start the server

    hexstrike_server --port 8888

### 3) On main OS — start MCP bridge

    hexstrike_mcp --server http://127.0.0.1:8888
