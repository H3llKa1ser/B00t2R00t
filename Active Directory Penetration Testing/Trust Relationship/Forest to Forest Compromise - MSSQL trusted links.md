# Forest to Forest compromise - MSSQL trusted links

#### 1) impacket-mssqlclient

    impacketmssqlclient -windows-auth DOMAIN/USER:PASSWORD@IP

### Trustlink --> sp_linkedservers --> use_link --> MSSQL Lateral Movement

#### 2) Powershell MSSQL module

    Get-SQLServerLinkCrawl -username USER -password PASSWORD -Verbose -Instance SQL_INSTANCE
