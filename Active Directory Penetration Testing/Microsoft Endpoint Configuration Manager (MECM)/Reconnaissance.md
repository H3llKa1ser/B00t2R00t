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
