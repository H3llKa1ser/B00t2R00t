### Enumeration commands:

#### 1) mount (As root in the docker container, to find any writeable devices/shares to mount to the file system)

#### 2) ls -la /var/run | grep sock (Shared namespaces)

#### 3) capsh --print (Capabilities)

#### 4) ss -tulpn (Check for internal services)

#### 5) ip a (Check the network the container is in), then portscan the CIDR to check other hosts within the network
