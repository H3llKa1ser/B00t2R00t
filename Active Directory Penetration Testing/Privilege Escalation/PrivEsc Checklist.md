# PrivEsc Checklist

### 1) Recycle Bin

    cd 'c:\$recycle.bin\<User SID>'
    dir /A

### 2) Passwords

    findstr /si password *.txt
    findstr /si password *.xml
    findstr /si password *.ini
    findstr /si pass *.txt
    findstr /si pass *.xml
    findstr /si pass *.ini

##### Find all those strings in config files.

    dir /s *pass* == *cred* == *vnc* == *.config*

### 3) If current user can read Event Logs then get the latest PowerShell commands run on the system

    Get-EventLog -LogName 'Windows PowerShell' -Newest 100 | Select-Object -Property * 

### 4) Sticky Notes for Passwords

    C:\Users\<user>\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState\plum.sqlite

### 5) Unquoted Service Paths

    wmic service get name,pathname,displayname,startmode | findstr /i auto | findstr /i /v "C:\Windows\\" | findstr /i /v """

### 6) Running Services

    wmic service get Caption,StartName,State,pathname
    net start

### 7) DNS Cache

    ipconfig /displaydns

### 8) Network Drives

    net share
    Get-SMBMapping

### 9) Active Connections

    netstat -ano
    Get-NetTCPConnection

### 10) Routing Table

    route print

### 11) Local and network drives

    wmic logicaldisk get deviceid, volumename, description
    get-psdrive -psprovider filesystem

### 12) Environment Variables

    set
    Get-ChildItem Env: | ft Key,Value

