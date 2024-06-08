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

#### wfuzz -c -z range,1-65535 http://TARGET_IP/url.php?path=127.0.0.1:FUZZ

### TIP: If you find yourself some files with SSRF, don't forget to check their contents by viewing the page source!

## Important Files to check out with SSRF:

 - file:///etc/passwd

 - file:///proc/self/cmdline
