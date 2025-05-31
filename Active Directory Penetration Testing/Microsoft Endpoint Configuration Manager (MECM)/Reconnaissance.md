# Reconnaissance

## Common Ports

| Protocol | Port(s)         | Service                                 |
|----------|------------------|------------------------------------------|
| TCP      | 8530, 8531       | Site Server, Management Point            |
| TCP      | 10123            | Site Server, Management Point            |
| TCP      | 49152–49159      | Distribution Point                       |
| UDP      | 4011             | Operating System Deployment (OSD)        |

### 1) Nmap

##### Search SCCM

    nmap -p 80,443,445,1433,10123,8530,8531 -sV [IP]

##### Search PXE

    nmap -p 67,68,69,4011,547 -sV -sU [IP]

### 2) Powershell

    ([ADSISearcher]("objectClass=mSSMSManagementPoint")).FindAll() | % {$_.Properties}

### 3) sccmhunter

    python3 sccmhunter.py find -u <user> -p <password> -d <domain> -dc-ip <ip> -debug

##### Review collected information

    python3 sccmhunter.py show -all 

### 4) Smbmap

    smbmap -u <user> -p <password> -d <domain> -H <ip> 


# Enumeration

Techniques to identify SCCM servers and related objects in an Active Directory

## Windows

### With PowerShell

    ([ADSISearcher]("objectClass=mSSMSManagementPoint")).FindAll() | % {$_.Properties}

### With SharpSCCM

    ./SharpSCCM.exe local site-info
    ./SharpSCCM.exe local client-info

## Linux

### Find the assets in the LDAP configuration

    python3 sccmhunter.py find -u user1 -p password -d domain.local -dc-ip <DC_IP>

### Retrieve informations regarding the identified servers (SMB signing, site code, server type, etc)
### And save PXE variables

    python3 sccmhunter.py smb -u user1 -p password -d domain.local -dc-ip <DC_IP> -save

### Show results from the previous commands

    python3 sccmhunter.py show -smb
    python3 sccmhunter.py show -user
    python3 sccmhunter.py show -computers
    python3 sccmhunter.py show -all
