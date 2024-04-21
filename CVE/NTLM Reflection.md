# NTLM Reflection CVE-2008-4037 MS08-068

### This vulnerability allows an attacker to redirect an incoming SMB connection back to the machine it came from and then access the victim machine using the victim’s own credentials.

## Link: https://github.com/SecWiki/windows-kernel-exploits/tree/master/MS08-068

### Usage:

#### 1) Metasploit

 - msf > use exploit/windows/smb/smb_relay

 - msf exploit(smb_relay) > show targets
