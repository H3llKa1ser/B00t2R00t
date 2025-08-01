# Passwordsafe (psafe) credential recovery

## Tool: Hashcat, Passwordsafe https://pwsafe.org/ (Cross-Platform)

### Usage:

    hashcat -m 5200 -a 0 FILE.psafe3 /usr/share/wordlists/rockyou.txt

    passwordsafe FILE.psafe3 (Insert cracked password to gain access to the file contents)
