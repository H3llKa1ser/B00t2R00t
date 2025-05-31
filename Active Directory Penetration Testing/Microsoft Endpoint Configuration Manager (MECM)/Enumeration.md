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
