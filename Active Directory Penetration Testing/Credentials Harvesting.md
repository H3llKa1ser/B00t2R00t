# FORMS

### 1) Account Details

### 2) Hashes (NTLM,etc)

### 3) Authentication tickets (TGT,TGS,etc)

#### 4) Private keys, etc.

# INSECURE LOCATIONS

### 1) Cleartext files

### 2) Database files

### 3) Memory

### 4) Password managers

### 5) Enterprise vaults

### 6) Active Directory

### 7) Network Sniffing

# LOCAL WINDOWS CREDENTIALS 

### 1) Keystrokes

### 2) SAM (C:\windows\system32\config\sam)

### 3) Metasploit hashdump module

### 4) Volume shadow copy service

#### wmic shadowcopy call create Volume='C:\'

### vssadmin list shadows

### copy sam/system hives to desktop
