# Password in AD User comment

### There are times that we may find sensitive data in user descripions within an AD environment

    crackmapexec ldap domain.lab -u 'username' -p 'password' -M user-desc

    crackmapexec ldap 10.0.2.11 -u 'username' -p 'password' --kdcHost 10.0.2.11 -M get

### There are 3-4 fields that seem to be common in most AD schemas:

 - UserPassword

 - UnixUserPassword

 - unicodePwd

 - msSFU30Password

#### 1) enum4linux

    enum4linux | grep -i desc

#### 2) Powershell

    Get-WmiObject -Class Win32_UserAccount -Filter "Domain='COMPANYDOMAIN' AND Disabled='

### Or dump the AD and grep the content

    ldapdomaindump -u 'DOMAIN\john' -p MyP@ssW0rd 10.10.10.10 -o ~/Documents/AD_DUMP/
