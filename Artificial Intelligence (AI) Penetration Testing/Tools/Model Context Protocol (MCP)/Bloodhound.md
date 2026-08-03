# Bloodhound MCP

# DISCLAIMER: NEVER IMPORT REAL CLIENT DATA INTO THE AI! THE DATA WILL FLOW THROUGH ANTHROPIC (OR ANY PROVIDER IN THAT CASE) SERVERS!

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

## Execution and Usage

### 1) Collect AD data

    bloodhound-python -u USER -p PASSWORD -ns DNS_IP -d domain.local -c All

### 2) Ingest data into Bloodhound

Go to:

    Quick Upload -> Drag the collector's JSON files into the Drop Menu -> Confirm and Upload

## Prompts

### 1) List prompts to use

    help

### 2) Gather full domain information

    find all domain information

### 3) Find Kerberoastable users

    find all kerberoastable users

### 4) Enumerate Domain Admins

    show me all Domain Admins in domain.local

### 5) Enumerate all Domain Users

    show all users in domain.local

### 6) Show members of a specific group

    show members of the GROUP_NAME group

### 7) Check for DCSync rights

    check for DCSync rights

### 8) Find ASREPRoastable users

    find all AS-REP roastable users

### 9) Check for Password Not-Required accounts

    find accounts with password not required

### 10) Mapp ForceChangePassword Edges

    show all Reset Password Edges

### 11) AllExtendedRights and LAPS

    show all allExtendedright Edges

### 12) Shadow Credentials

    Shadow Credentials Attack

### 13) GenericAll edges

    show all GenericAll Edges

### 14) GPO Abuse

    Want me to check GPoAbuse

### 15) Enumerate Domain Computers

    show all computers in domain.local

### 16) Outbound Object-Control ACLs

    find all users with outbound Object Control ACL

### 17) AdminSDHolder Backdoor

    find adminsdholder

### 18) Shortest path to Domain Admins

    find shortest path to DA

### 19) Constrained Delegation

    find constrained delegation

### 20) Unconstrained delegation

    find unconstrained delegation

### 21) Resource-based Constrained Delegation RBCD

    find resource based constrained delegation

### 22) Dangerous Privileges

    dangerous privileges

### 23) Prioritise Attack Surface

    updated attack surface summary
