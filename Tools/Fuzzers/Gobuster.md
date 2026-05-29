# Gobuster

Directory/Subdomain/vhost enumeration

### 1) Subdomain Enumeration (Configure DNS first)

    gobuster dns -d domain.local -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt --wildcard

### 2) Directory Enumeration

    gobuster dir -u http://TARGET_IP -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt -r

### 3) VHost Enumeration (Does not use DNS)

    gobuster vhost -u "http://TARGET_IP" --domain domain.local -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt --append-domain --exclude-length 250-320 

