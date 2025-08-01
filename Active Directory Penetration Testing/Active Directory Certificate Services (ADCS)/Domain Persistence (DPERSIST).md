# AD CS Domain Persistence (DPERSIST)

## Tools: ForgeCert https://github.com/GhostPack/ForgeCert

# DPERSIST1 - Forging Certificates with Stolen CA Certificates

## How can you tell that a certificate is a CA certificate?

### It can be determined that a certificate is a CA certificate if several conditions are met:

#### 1) The certificate is stored on the CA server, with its private key secured by the machine's DPAPI, or by hardware such as a TPM/HSM if the operating system supports it.

#### 2) Both the Issuer and Subject fields of the certificate match the distinguished name of the CA.

#### 3) A "CA Version" extension is present in the CA certificates exclusively.

#### 4) The certificate lacks Extended Key Usage (EKU) fields.

### To extract the private key of this certificate, the certsrv.msc tool on the CA server is the supported method via the built-in GUI. Nonetheless, this certificate does not differ from others stored within the system; thus, methods such as the THEFT2 technique can be applied for extraction.

### The certificate and private key can also be obtained using Certipy with the following command:

    certipy ca 'corp.local/administrator@ca.corp.local' -hashes :123123.. -backup

### Upon acquiring the CA certificate and its private key in .pfx format, tools like ForgeCert can be utilized to generate valid certificates:

    ForgeCert.exe --CaCertPath ca.pfx --CaCertPassword Password123! --Subject "CN=User" --SubjectAltName localadmin@theshire.local --NewCertPath localadmin.pfx --NewCertPassword Password123! (Generating a new certificate with ForgeCert)

    certipy forge -ca-pfx CORP-DC-CA.pfx -upn administrator@corp.local -subject 'CN=Administrator,CN=Users,DC=CORP,DC=LOCAL' (Generating a new certificate with certipy

    Rubeus.exe asktgt /user:localdomain /certificate:C:\ForgeCert\localadmin.pfx /password:Password123! (Authenticating using the new certificate with Rubeus)

    certipy auth -pfx administrator_forged.pfx -dc-ip 172.16.126.128 (Authenticating using the new certificate with certipy)

## TIP: The user targeted for certificate forgery must be active and capable of authenticating in Active Directory for the process to succeed. Forging a certificate for special accounts like krbtgt is ineffective.

### This forged certificate will be valid until the end date specified and as long as the root CA certificate is valid (usually from 5 to 10+ years). It's also valid for machines, so combined with S4U2Self, an attacker can maintain persistence on any domain machine for as long as the CA certificate is valid. Moreover, the certificates generated with this method cannot be revoked as CA is not aware of them.

# DPERSIST2 - Trusting Rogue CA Certificates

### The NTAuthCertificates object is defined to contain one or more CA certificates within its cacertificate attribute, which Active Directory (AD) utilizes. The verification process by the domain controller involves checking the NTAuthCertificates object for an entry matching the CA specified in the Issuer field of the authenticating certificate. Authentication proceeds if a match is found.

### A self-signed CA certificate can be added to the NTAuthCertificates object by an attacker, provided they have control over this AD object. Normally, only members of the Enterprise Admin group, along with Domain Admins or Administrators in the forest root’s domain, are granted permission to modify this object. They can edit the NTAuthCertificates object using certutil.exe with the command certutil.exe -dspublish -f C:\Temp\CERT.crt NTAuthCA126, or by employing the PKI Health Tool.

### This capability is especially relevant when used in conjunction with a previously outlined method involving ForgeCert to dynamically generate certificates.

# DPERSIST3 - Malicious Misconfiguration

### Opportunities for persistence through security descriptor modifications of AD CS components are plentiful. Modifications described in the "Domain Escalation" section can be maliciously implemented by an attacker with elevated access. This includes the addition of "control rights" (e.g., WriteOwner/WriteDACL/etc.) to sensitive components such as:

#### 1) The CA server’s AD computer object

#### 2) The CA server’s RPC/DCOM server

#### 3) Any descendant AD object or container in CN=Public Key Services,CN=Services,CN=Configuration,DC=DOMAIN,DC=COM (for instance, the Certificate Templates container, Certification Authorities container, the NTAuthCertificates object, etc.)

#### 4) AD groups delegated rights to control AD CS by default or by the organization (such as the built-in Cert Publishers group and any of its members)

### An example of malicious implementation would involve an attacker, who has elevated permissions in the domain, adding the WriteOwner permission to the default User certificate template, with the attacker being the principal for the right. To exploit this, the attacker would first change the ownership of the User template to themselves. Following this, the mspki-certificate-name-flag would be set to 1 on the template to enable ENROLLEE_SUPPLIES_SUBJECT, allowing a user to provide a Subject Alternative Name in the request. Subsequently, the attacker could enroll using the template, choosing a domain administrator name as an alternative name, and utilize the acquired certificate for authentication as the DA.

