### Group Policy Preferences (GPP) allowed admins to create policies using embedded credentials

### These credentials were encrypted and placed in a "cPassword"

### They key was accidentally released 

### Pacthed in MS14-025, but it doesn't prevent previous uses

### GPP is an .xml file stored in SYSVOL directory

### command: gpp-decrypt CPASSWORD
