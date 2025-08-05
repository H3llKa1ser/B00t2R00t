# Authentication

### You can authenticate on the remote target using a domain account or a local user

## Indicators

 - When authentication fail => COLOR RED

 - When authentication success => COLOR GREEN

 - When authentication fail but the password provided is valid => COLOR MAGENTA

# Checking Credentials (Domain)

## Indicators

 - Failed logins result in a [-]

 - Successful logins result in a [+] Domain\Username:Password

### Local admin access results in a (Pwn3d!) added after the login confirmation, shown below.

SMB         192.168.1.101    445    HOSTNAME          [+] DOMAIN\Username:Password (Pwn3d!)

### The following checks will attempt authentication to the entire /24 though a single target may also be used.

## User/Password

    nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE'

## User/Hash

### After obtaining credentials such as Administrator:500:aad3b435b51404eeaad3b435b51404ee:13b29964cc2480b4ef454c59562e675c::: you can use both the full hash or just the nt hash (second half)

    nxc smb 192.168.1.0/24 -u UserNAme -H 'LM:NT'

    nxc smb 192.168.1.0/24 -u UserNAme -H 'NTHASH'

    nxc smb 192.168.1.0/24 -u Administrator -H '13b29964cc2480b4ef454c59562e675c'

    nxc smb 192.168.1.0/24 -u Administrator -H 'aad3b435b51404eeaad3b435b51404ee:13b29964cc2480b4ef454c59562e675c'

# Checking Credentials (Local)

## User/Password/Hashes

### Adding --local-auth to any of the authentication commands with attempt to logon locally.

    nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --local-auth

    nxc smb 192.168.1.0/24 -u '' -p '' --local-auth

    nxc smb 192.168.1.0/24 -u UserNAme -H 'LM:NT' --local-auth

    nxc smb 192.168.1.0/24 -u UserNAme -H 'NTHASH' --local-auth

    nxc smb 192.168.1.0/24 -u localguy -H '13b29964cc2480b4ef454c59562e675c' --local-auth

    nxc smb 192.168.1.0/24 -u localguy -H 'aad3b435b51404eeaad3b435b51404ee:13b29964cc2480b4ef454c59562e675c' --local-auth

### Results will display the hostname next to the user:password

SMB         192.168.1.101    445    HOSTNAME          [+] HOSTNAME\Username:Password (Pwn3d!)  
