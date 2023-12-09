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
