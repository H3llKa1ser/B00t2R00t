# Enumeration via SMB

## Enumeration on NetExec

# Host Enumeration

#### nxc smb 192.168.1.0/24 (Returns a list of live hosts)

# Null Sessions

### Checking if Null Session is enabled on the network, can be very useful on a Domain Controller to enumerate users, groups, password policy etc

#### nxc smb 10.10.10.161 -u '' -p ''

#### nxc smb 10.10.10.161 -u '' -p '' --shares (Shares enumeration)

#### nxc smb 10.10.10.161 -u '' -p '' --pass-pol (Password policy enumeration)

#### nxc smb 10.10.10.161 -u '' -p '' --users (User enumeration)

#### nxc smb 10.10.10.161 -u '' -p '' --groups (Group enumeration)

### You can also reproduce this behavior with smbclient or rpcclient

#### smbclient -N -U "" -L \\10.10.10.161

#### rpcclient -N -U "" -L \\10.10.10.161

#### rpcclient $> enumdomusers

user:[bonclay] rid:[0x46e]

user:[zoro] rid:[0x46f]

# Anonymous Logon

### Using a random username and password you can check if the target accepts annonymous/guest logon

#### nxc smb 10.10.10.178 -u 'a' -p ''

### You can also check this behavior with smbclient or rpcclient

#### smbclient -N -L \\10.10.10.178

#### rpcclient -N -L 10.10.10.178

# Host Enumeration with SMB signing not required

### Maps the network of live hosts and saves a list of only the hosts that don't require SMB signing. List format is one IP per line

#### nxc smb 192.168.1.0/24 --gen-relay-list relay_list.txt

## Alternative with nmap 

#### nmap --script smb-security-mode.nse,smb2-security-mode.nse -p445 127.0.0.1

# Active Sessions

### Enumerate active sessions on the remote target

#### nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --sessions

# Shares and Access enumeration

### Enumerate permissions on all shares

#### nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --shares

### If you want to filter only by readable or writable share

#### #~ nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --shares --filter-shares READ WRITE

# Disk Enumeration

### Enumerate disks on the remote target

#### nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --disks

# Logged on Users Enumeration

### Enumerate logged users on the remote target

#### nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --loggedon-users

# Domain Users Enumeration

### Enumerate domain users on the remote target

#### nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --users

# RID Bruteforce

### Enumerate users by bruteforcing the RID on the remote target

#### nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --rid-brute

# Domain Groups Enumeration

### Enumerate domain groups on the remote target

#### nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --groups

# Local Groups Enumeration

### Enumerate local groups on the remote target

#### nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --local-group

# Domain Password Policy Enumeration

### Using the option --pass-pol you can get the password policy of the domain

#### nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --pass-pol

# Anti-Virus & EDR Enumeration

### Enumerate antivirus installed using NetExec

## You don't need to be a privileged user to do this action

#### nxc smb <ip> -u user -p pass -M enum_av
