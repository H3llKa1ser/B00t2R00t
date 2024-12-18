# Download / Upload MSSQL file

#### Upload 

    nxc mssql 10.10.10.52 -u admin -p 'm$$ql_S@_P@ssW0rd!' --put-file /tmp/users C:\\Windows\\Temp\\whoami.txt

#### Download 

    nxc mssql 10.10.10.52 -u admin -p 'm$$ql_S@_P@ssW0rd!' --get-file C:\\Windows\\Temp\\whoami.txt /tmp/file
