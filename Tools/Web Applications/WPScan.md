# Wpscan Wordpress Scanner

## Usage

### 1) Updates wpscan database

    wpscan --update 

### 2) All plugins enumeration

    wpscan --url http://domain.local/wordpress --plugins-detection aggressive

### 3) Theme enumeration

    wpscan --url http://domain.local/wordpress --enumerate -t
    
### 4) Plugin enumeration

    wpscan --url http://domain.local/wordpress --enumerate ap

### 5) User enumeration

    wpscan --url http://domain.local/wordpress --enumerate u

### 6) Password Attack

    wp scan --url http://domain.local/wordpress --passwords LIST --usernames USER

### 7) Vulnerable plugins enumeration

    wpscan --url http://domain.local/wordpress --enumerate -vp 


