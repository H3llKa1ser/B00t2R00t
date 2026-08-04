# Enumerate Impersonation Rights

### Authenticate with local SQL credentials and list every login the current user can impersonate via EXECUTE AS

    nxc mssql $ip -u $user -p $password -M enum_impersonate --local-auth
