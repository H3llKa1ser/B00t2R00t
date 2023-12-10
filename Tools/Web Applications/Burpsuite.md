# BURPSUITE WEB PROXY TOOL (USE IT WITH FOXYPROXY BROWSER EXTENSION)

### Burpsuite generates its own TLS certificate for each host, signed by its own Certificate Authority (CA)

### Ensure you install Burp's CA Certificate for HTTPS sites

### Can be found at http://burpsuite

### Import certificate into browser

## TIP: Burpsuite has an embedded browser to use (Chromium)

# PROXY

### Intercet is on by default

### Can modify packet before it is sent to the web server

### Can send requests to other Burpsuite tools under "actions"

# REPEATER

### Can try different requests without having to use a browser

### Great for analyzing things like Time-based SQL injections (example)

### Can easily analyze different behavior by web server from requests

# INTRUDER

### Intruder is a tool to brute-force logins or fuzz web applications

### Can grep for specific strings

### You need to specify the position for the attack

## INTRUDER ATTACK TYPES 

### Sniper = Attacks only one position at a time

### Battering Ram = Places the same payload value in all positions

### Pitchfork = Uses one payload set for each position. It places the first payload in the first position, the second payload in the second position, and so on and so forth.

### Cluster Bomb = The cluster bomb attack tries all different combinatipons of payloads. It still puts the first payload in the first position and the second payuload in the second position. But when it loops through the payload sets, it tries all the combinations.

# DECODER

### Can both encode/decode

#### 1) Base64

#### 2) URL

#### 3) HTML

#### 4) ASCII Hex

#### 5) Hex

#### 6) Octal

#### 7) Binary

#### 8) Gzip
