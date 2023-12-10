# FFUF FUZZER TOOL

### FUZZ = Tells program where to fuzz

### #-u = URL 

#### -w = wordlist

### We can fuzz parameters to check for SQLi, XSS, etc.

### Example: 

#### ffuf -u http://IP_ADDRESS/file.php?id=FUZZ

#### ffuf -u http://IP_ADDRESS/file.php?FUZZ=1'

#### --mc = Match code

#### --fc = Filter code

#### -c = color output

#### -fs NUM = File Size

### Subdomain enumeration example:

#### ffuf -u http://example.com -c -w /path/to/wordlist.txt -H 'Host: FUZZ.example.com' -fs 0

#### -x PROXY:PORT = Sends all ffuf traffic through a web proxy (Burpsuite, network pivoting)

### TIP: We can even use regex to find for files
