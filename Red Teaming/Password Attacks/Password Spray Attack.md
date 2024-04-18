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

