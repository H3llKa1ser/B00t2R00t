# SSRF Defense Bypass

### 1: Deny list (localhost, 127.0.0.1)

### Subdomains that have a DNS record which resolves to the IP Address such as: 

### 127.0.0.1.nip.io and 169.2.54.169.254 (Cloud)

## Alternate localhost references:

### 0, 0.0.0.0, 0000, 127.1, 127.*.*.*, 213070643, 017700000001

## 2: Allow list:

### Create a subdomain on an attacker's domain name.

### E.G. Whitelisted rule: 

    http://website.com

### Attacker subdomain: 

    http://website.attacker.com

## 3: Open Redirect (Bypass strict rules)

### Example: 

    http://website.com/link?url=http://attacker.com
