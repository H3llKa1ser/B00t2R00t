# ADCS Certificate Theft (THEFT)

## Tools: CertStealer https://github.com/TheWover/CertStealer , SharpDPAPI https://github.com/GhostPack/SharpDPAPI

# THEFT1 - Exporting Certificates Using the Crypto APIs

### In an interactive desktop session, extracting a user or machine certificate, along with the private key, can be easily done, particularly if the private key is exportable. This can be achieved by navigating to the certificate in certmgr.msc, right-clicking on it, and selecting All Tasks → Export to generate a password-protected .pfx file.

### For a programmatic approach, tools such as the PowerShell ExportPfxCertificate cmdlet or projects like TheWover’s CertStealer C# project are available. These utilize the Microsoft CryptoAPI (CAPI) or the Cryptography API: Next Generation (CNG) to interact with the certificate store. These APIs provide a range of cryptographic services, including those necessary for certificate storage and authentication.

### However, if a private key is set as non-exportable, both CAPI and CNG will normally block the extraction of such certificates. To bypass this restriction, tools like Mimikatz can be employed. Mimikatz offers crypto::capi and crypto::cng commands to patch the respective APIs, allowing for the exportation of private keys. Specifically, crypto::capi patches the CAPI within the current process, while crypto::cng targets the memory of lsass.exe for patching.

# THEFT2 - User Certificate Theft via DPAPI

### In Windows, certificate private keys are safeguarded by DPAPI. It's crucial to recognize that the storage locations for user and machine private keys are distinct, and the file structures vary depending on the cryptographic API utilized by the operating system. SharpDPAPI is a tool that can navigate these differences automatically when decrypting the DPAPI blobs.

### User certificates are predominantly housed in the registry under HKEY_CURRENT_USER\SOFTWARE\Microsoft\SystemCertificates, but some can also be found in the directory %APPDATA%\Microsoft\SystemCertificates\My\Certificates. The corresponding private keys for these certificates are typically stored in %APPDATA%\Microsoft\Crypto\RSA\User SID\ for CAPI keys and %APPDATA%\Microsoft\Crypto\Keys\ for CNG keys.

### To extract a certificate and its associated private key, the process involves:

#### 1) Selecting the target certificate from the user’s store and retrieving its key store name.

#### 2) Locating the required DPAPI masterkey to decrypt the corresponding private key.

#### 3) Decrypting the private key by utilizing the plaintext DPAPI masterkey.

### For acquiring the plaintext DPAPI masterkey, the following approaches can be used:

    dpapi::masterkey /in:"C:\PATH\TO\KEY" /rpc (With Mimikatz, when running in the user's context)

    dpapi::masterkey /in:"C:\PATH\TO\KEY" /sid:accountSid /password:PASS (With Mimikatz, if the user's password is known)

### To streamline the decryption of masterkey files and private key files, the certificates command from SharpDPAPI proves beneficial. It accepts /pvk, /mkfile, /password, or {GUID}:KEY as arguments to decrypt the private keys and linked certificates, subsequently generating a .pem file.

    SharpDPAPI.exe certificates /mkfile:C:\temp\mkeys.txt (Decrypting using SharpDPAPI)

    openssl pkcs12 -in cert.pem -keyex -CSP "Microsoft Enhanced Cryptographic Provider v1.0" -export -out cert.pfx (Converting .pem to .pfx)

# THEFT3 - Machine Certificate Theft via DPAPI

### Machine certificates stored by Windows in the registry at HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates and the associated private keys located in %ALLUSERSPROFILE%\Application Data\Microsoft\Crypto\RSA\MachineKeys (for CAPI) and %ALLUSERSPROFILE%\Application Data\Microsoft\Crypto\Keys (for CNG) are encrypted using the machine's DPAPI master keys. These keys cannot be decrypted with the domain’s DPAPI backup key; instead, the DPAPI_SYSTEM LSA secret, which only the SYSTEM user can access, is required.

### Manual decryption can be achieved by executing the lsadump::secrets command in Mimikatz to extract the DPAPI_SYSTEM LSA secret, and subsequently using this key to decrypt the machine masterkeys. Alternatively, Mimikatz’s crypto::certificates /export /systemstore:LOCAL_MACHINE command can be used after patching CAPI/CNG as previously described.

### SharpDPAPI offers a more automated approach with its certificates command. When the /machine flag is used with elevated permissions, it escalates to SYSTEM, dumps the DPAPI_SYSTEM LSA secret, uses it to decrypt the machine DPAPI masterkeys, and then employs these plaintext keys as a lookup table to decrypt any machine certificate private keys.

# THEFT4 - Finding Certificate Files

### Certificates are sometimes found directly within the filesystem, such as in file shares or the Downloads folder. The most commonly encountered types of certificate files targeted towards Windows environments are .pfx and .p12 files. Though less frequently, files with extensions .pkcs12 and .pem also appear. Additional noteworthy certificate-related file extensions include:

 - .key for private keys,

 - .crt/.cer for certificates only,

 - .csr for Certificate Signing Requests, which do not contain certificates or private keys,

 - .jks/.keystore/.keys for Java Keystores, which may hold certificates along with private keys utilized by Java applications.

### These files can be searched for using PowerShell or the command prompt by looking for the mentioned extensions.

### In cases where a PKCS#12 certificate file is found and it is protected by a password, the extraction of a hash is possible through the use of pfx2john.py, available at fossies.org. Subsequently, JohnTheRipper can be employed to attempt to crack the password.

## Commands: 

#### 1) Search for certificate files in Powershell

    Get-ChildItem -Recurse -Path C:\Users\ -Include *.pfx, *.p12, *.pkcs12, *.pem, *.key, *.crt, *.cer, *.csr, *.jks, *.keystore, *.keys 

#### 2) Extract a hash from a PKCS#12 file

    pfx2john.py certificate.pfx > hash.txt 

#### 3) Crack the hash with John The Ripper

    john --wordlist=passwords.txt hash.txt 

# THEFT5 - NTLM Credential Theft via PKINIT 

### The given content explains a method for NTLM credential theft via PKINIT, specifically through the theft method labeled as THEFT5. Here's a re-explanation in passive voice, with the content anonymized and summarized where applicable:

### o support NTLM authentication [MS-NLMP] for applications that do not facilitate Kerberos authentication, the KDC is designed to return the user's NTLM one-way function (OWF) within the privilege attribute certificate (PAC), specifically in the PAC_CREDENTIAL_INFO buffer, when PKCA is utilized. Consequently, should an account authenticate and secure a Ticket-Granting Ticket (TGT) via PKINIT, a mechanism is inherently provided which enables the current host to extract the NTLM hash from the TGT to uphold legacy authentication protocols. This process entails the decryption of the PAC_CREDENTIAL_DATA structure, which is essentially an NDR serialized depiction of the NTLM plaintext.

### The utility Kekeo, accessible at https://github.com/gentilkiwi/kekeo, is mentioned as capable of requesting a TGT containing this specific data, thereby facilitating the retrieval of the user's NTLM. The command utilized for this purpose is as follows:

    Kekeo.exe tgt::pac /caname:generic-DC-CA /subject:genericUser /castore:current_user /domain:domain.local

### Additionally, it is noted that Kekeo can process smartcard-protected certificates, given the pin can be retrieved, with reference made to https://github.com/CCob/PinSwipe. The same capability is indicated to be supported by Rubeus, available at https://github.com/GhostPack/Rubeus.

### This explanation encapsulates the process and tools involved in NTLM credential theft via PKINIT, focusing on the retrieval of NTLM hashes through TGT obtained using PKINIT, and the utilities that facilitate this process.
