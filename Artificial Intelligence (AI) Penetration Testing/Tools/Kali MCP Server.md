# Kali MCP Server

Link: https://mcpservers.org/en/servers/k3nn3dy-ai/kali-mcp

Check available tool categories in the link above.

## Native installation

### 1) Install via apt

    sudo apt install mcp-kali-server

### 2) Start the API server

    kali-server-mcp --port 5000 --ip 127.0.0.1
    # --debug flag available for verbose output
    # --ip 0.0.0.0 to bind all interfaces (dangerous — avoid on untrusted networks)

### 3) Start the MCP Bridge (same machine)

    mcp-server --server http://127.0.0.1:5000

## Remote SSH Tunnel Setup

### 1) Terminal 1 — tunnel to Kali

    ssh -L 5000:localhost:5000 user@KALI_IP

### 2)  Terminal 2 — run the MCP bridge locally

    git clone https://github.com/Wh0am123/MCP-Kali-Server.git
    cd MCP-Kali-Server
    python3 -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt
    ./client.py --server http://127.0.0.1:5000

## Docker (Isolated)

### 1) Self-contained environment

    git clone https://github.com/hassanaftab93/kali-docker-mcp
    cd kali-docker-mcp
    docker compose up --build -d

# Connecting to Claude Desktop

#### claude_desktop_config.json

    {
      "mcpServers": {
        "kali": {
          "transport": "sse",
          "url": "http://localhost:5000/sse"
        }
      }
    }

#### Docker Variant

    {
      "mcpServers": {
        "kali-mcp-server": {
          "type": "stdio",
          "command": "docker",
          "args": ["exec", "-i", "kali-mcp-server", "python3", "/app/kali_server.py"]
        }
      }
    }
    ```
    
    ---
    
    ## Usage Examples
    
    Once connected, you interact via natural language in the AI client. The model translates prompts to tool calls:
    ```
    "Run an nmap version scan against 192.168.1.10"
    "Run gobuster on http://target.htb with a common wordlist"
    "Use hydra to brute SSH on 10.10.10.5 with rockyou.txt"

