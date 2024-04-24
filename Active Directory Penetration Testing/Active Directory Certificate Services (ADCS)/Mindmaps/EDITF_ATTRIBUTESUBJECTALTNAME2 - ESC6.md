# ESC6 - EDITF_ATTRIBUTESUBJECTALTNAME2

## Enumeration

 - certutil -config "CA_HOST\CA_NAME" -getreg "policy\EditFlags"

 - certipy / certify.exe (only the flag ATTRIBUTESUBJECTALTNAME2)

## Exploitation

### Abuse ATTRIBUTESUBJECTALTNAME2 flag set on CA. You can choose any certificate template that permits client authentication. 

### Then proceed to ESC1 technique
