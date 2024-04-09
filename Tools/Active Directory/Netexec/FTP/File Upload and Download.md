# File Upload and Download

### Instructions for using FTP commands to access and transfer files using NetExec.

## List files in a specific directory using FTP.

#### netexec ftp [IP_ADDRESS] -u [USERNAME] -p [PASSWORD] --ls [DIRECTORY]

## Download a file from the FTP server.

#### netexec ftp [IP_ADDRESS] -u [USERNAME] -p [PASSWORD] --get [FILE]

## Upload a file to the FTP server providing you have relevant permissions

#### netexec ftp [IP_ADDRESS] -u [USERNAME] -p [PASSWORD] --put [LOCAL_FILE] [REMOTE_FILE]
