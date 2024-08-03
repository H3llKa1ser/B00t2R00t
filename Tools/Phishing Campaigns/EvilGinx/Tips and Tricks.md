# Evilginx Tips and Tricks

### Sometimes, even if we have captured the login credentials for Azure (example) and we may try to login to Azure portal, we may still get prompted for an MFA token.

### This is because Microsoft has advanced detection capabilities and the free community version of EvilGinx is easily detected. If you have the Pro version of Evilginx you would now be able to use the cookies and access the Azure portal!

###  The Pro version of Evilginx has more advanced evasion capabilities that could allow it to capture login sessions without being detected. However, this is a familiar cat and mouse game with new detections being met with evasion techniques, followed by more detections and evasion techniques.

### What Microsoft do when they detect Evilginx, it automatically triggers a reauthentication for the user, if they detect that a login seems malicious, thereby invalidating the existing token and the provided MFA code. As the token is automatically invalidated, we are prompted for an MFA code even though we know the user's username and password. Other sites may have less advanced detection capabilities.
