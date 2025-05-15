# User Hunting

### Sometimes you need to find a machine where a specific user is logged in. You can remotely query every machines on the network to get a list of the users's sessions.

#### 1) CrackMapExec

 - cme smb 10.10.10.0/24 -u Administrator -p 'P@ssw0rd' --sessions

#### 2) Impacket smbclient

 - impacket-smbclient Administrator@10.10.10.10

 - who

#### 3) Powerview Invoke-UserHunter

### Find computers where a Domain Admin or a specific user has a session

 - Invoke-UserHunter

 - Invoke-UserHunter -GroupName" RDPUsers"

 - Invoke-UserHunter -Stealth
