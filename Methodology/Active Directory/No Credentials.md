# No Credentials

### 1) Scan the machine

    sudo rustscan -a IP -r 1-65535 -- -A -Pn -oA

Analyze the scan output. If we find a domain, make an entry in the hosts file

    sudo nano /etc/hosts
    IP  domain.local

### 2) Do reconnaissance for credentials (users and passwords)

#### SMB

Check SMB information for null session and guest access, as well as general information about the machine

    enum4linux-ng IP

Check for null session and/or guest access for SMB share access

    nxc smb domain.local -u '' -p '' --shares
    nxc smb domain.local -u guest -p '' --shares

Dump all valid users in the domain via RID cycling

    nxc smb domain.local -u '' -p '' --rid-brute

#### Kerberos

If we find a list of usernames, check if these usernames are valid

    kerbrute userenum -d domain.local --dc dc.domain.local users.txt

If we have no hints for finding a username list, we can enumerate using a specific wordlist

    kerbrute userenum -d domain.local --dc dc.domain.local /usr/share/wordlists/seclists/Usernames/xato-net-10-million-usernames.txt
    kerbrute userenum -d domain.local --dc dc.domain.local /usr/share/wordlists/seclists/Usernames/top-usernames-shortlist.txt

#### LDAP

Enumerate the domain via LDAP

    ldapsearch -v -x -b "DC=domain,DC=local" -H "ldap://DC_IP" "(objectclass=*)"

Enumerate users

    nxc ldap domain.local -u '' -p '' --users

#### HTTP

Enumerate directories

    feroxbuster --url http://domain.local -w /usr/share/wordlists/dirb/common.txt -C 404,500,400,403

Enumerate subdomains

    ffuf -u http://domain.local -c -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-110000.txt -H 'Host: FUZZ.domain.local' 

#### DNS

Do a DNS Zone transfer

    dig axfr @DNS_IP
    dig axfr @DNS_IP domain.local
