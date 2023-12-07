## Tools: Burpsuite/OWASP ZAP

## Headers:

### X-RateLimit-Limit

### X-RateLimit-Remaining

### X-RateLimit-Reset

## Headers that can be used to bypass rate limit

### X-Forwarded-For:IP

### X-Forwarded-Host:IP

### X-Client-IP:IP

### X-Remote-IP:IP

### X-Remote-Addr:IP

### X-Host:IP

## TIP: Sometimes, multiple headers can bypass a rate limit.

# Rate Limit Captcha Bypass

### 1: Try removing CAPTCHA parameter from the body of the request

### 2: Try adding some string of the same length as that of the parameter

### 3: Keep the intercept ON, send request to intruder

# Rate Limit Bypass with some characters

### 1: Adding Null Byte (%00) at the end of the email can sometimes bypass rate limit

### 2: Try adding a space character after an email (Not Encoded)

### 3: Common characters that help bypass rate limits: %0d %2e %09 %20 %0 %0a %0C

#### Burp Extension: IP Rotate
