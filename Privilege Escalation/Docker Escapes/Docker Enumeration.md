# Docker Enumeration

### Enumeration commands:

#### 1) As root in the docker container, to find any writeable devices/shares to mount to the file system

    mount 
    
#### 2) Shared namespaces

    ls -la /var/run | grep sock 

#### 3) Capabilities

    capsh --print 

#### 4) Check for internal services

    ss -tulpn 

#### 5) Check the network the container is in, then portscan the CIDR to check other hosts within the network

    ip a 
