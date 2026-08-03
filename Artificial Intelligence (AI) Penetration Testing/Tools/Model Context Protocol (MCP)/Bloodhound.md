# Bloodhound MCP

## Installation

### 1) Clone the repository

    git clone https://github.com/mwnickerson/bloodhound_mcp

Then,

    cd bloodhound_mcp

### 2) Install

    uv sync

## Launch

### 1) Start bloodhound community edition

    bloodhound-start

Browse to

    http://127.0.0.1:8080

### 2) Generate Bloodhound API token

In the GUI Menu, go to:

    Administration -> Manage Users -> Gear menu beside the admin account to Generate / Revoke API tokens

Configure the environment file (.env)

    cd bloodhound_mcp
    cat .env

Then, insert values accordingly

### 3) Integrate Bloodhound MCP with Claude Desktop

Launch Claude Desktop on Kali, then go to:

    Click your account name -> Settings -> Desktop App -> Developer -> Edit Config

Upload the Claude configuration file:

    claude_desktop_config.json

The README file of the project provides the configuration block.

Set --directory to the cloned repository's absolute path, so Claude Desktop starts the server with uv run main.py

Save, then restart.
