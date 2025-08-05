# Authentication

## Testing Credentials

### You can use two methods to authenticate to the MSSQL: windows or local (default: windows). To use local auth, add the following flag --local-auth

# Windows Auth

## With SMB port open

    #~ nxc mssql 10.10.10.52 -u james -p 'J@m3s_P@ssW0rd!'

## With SMB port closed, add the flag -d DOMAIN

    #~ nxc mssql 10.10.10.52 -u james -p 'J@m3s_P@ssW0rd!' -d HTB

# Local Auth

    #~ nxc mssql 10.10.10.52 -u admin -p 'm$$ql_S@_P@ssW0rd!' --local-auth

# Specify Ports

    #~ nxc mssql 10.10.10.52 -u admin -p 'm$$ql_S@_P@ssW0rd!' --port 1434
