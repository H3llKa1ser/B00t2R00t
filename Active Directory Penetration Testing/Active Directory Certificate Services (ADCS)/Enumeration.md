# ADCS Misconfigurations/Vulnerabilities enumeration

## 1) Get templates information

 - certutil -v -dsTemplate

 - certify.exe find [/vulnerable]

 - certipy find -u USER@DOMAIN -p PASSWORD -dc-ip DC

### If we find true positive results, we proceed to exploitation via ESC1 (Request a certificate from a vulnerable template), ESC2 and ESC3 (Use an enrollment agent to request a certificate) Techniques

## 2) Get ACL Information

 - certipy find -u USER@DOMAIN -p PASSWORD -dc-ip DOMAIN_CONTROLLER

### If we find true positive results, we proceed to exploitation via ESC4 and ESC7 techniques

## 3) Display CA Information

 - certutil -TCAInfo

 - certify.exe cas

## 4) Get PKI Objects Information

 - certify.exe pkiobjects

### If we find true positive results, we proceed to exploitation via ESC5 technique

## 5) Get CA Flags (if remote registry is enabled)

 - certutil -config "CA_HOST\CA_NAME" -getreg "policy\EditFlags"

 - certipy / certify.exe (only the flag ATTRIBUTESUBJECTALTNAME2)

### If we find true positive results, we proceed to exploitation via ESC6 technique

## If Web enrollment is up, we can proceed to exploitation via the ESC8 technique
