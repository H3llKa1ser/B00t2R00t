# MSSQL Database Authentication and Dumping

### Commands:

 - impacket-mssqlclient -k DOMAIN.LOCAL (Kerberos auth example)

### DATABASE COMMANDS

 - SELECT name FROM sys.databases; (Enumerate all databases within MSSQL instance)

 - SELECT TABLE_NAME FROM targetdb.INFORMATION_SCHEMA.TABLES; (Enumerate tables of the target database)

 - SELECT * FROM targetdb.dbo.targettable (Dump all the contents of the target table of the target database)
