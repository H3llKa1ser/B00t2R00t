# Kali MCP Server

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
