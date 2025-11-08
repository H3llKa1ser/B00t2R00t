# Wordpress

### 1) Scan Wordpress for general information

    wpscan --url http://domain.local/wordpress

### 2) Enumerate users

    wpscan --url http://domain.local/wordpress --enumerate u

### 3) Enumerate all plugins

    wpscan --url http://domain.local/wordpress --plugins-detection aggressive

### 4) Password Attack

    wpscan --url http://domain.local/wordpress --usernames USER --passwords /usr/share/wordlist/rockyou.txt

### 5) Enumerate themes

    wpscan --url http://domain.local/wordpress --enumerate t
