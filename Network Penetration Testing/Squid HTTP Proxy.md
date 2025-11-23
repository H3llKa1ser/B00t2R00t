## Squid HTTP proxy pentesting

## Tool: https://github.com/aancw/spose.git

### Default port: 3128

### Enumeration:

#### 1) cURL

#### (You can set this discovered service as proxy in your browser. However, if it is configured with HTTP authentication, you will be prompted for usernames and password.)

    curl --proxy http://TARGET_IP:3128 http://TARGET_IP 

#### 2) Proxyfied nmap

#### Configure proxychains to use the squid proxy by adding the following line at the end of proxychains.conf file:

    http  TARGET_IP 3128

#### Then

    sudo proxychains nmap -sT -p- -n localhost (Scan for internal ports by using the squid proxy)

### Exposed squid proxy can be used to gain access to internal applications or ssh connections

OR use the squidproxyscan.sh script below (Replace IP addresses and add more ports to scan)

    #!/bin/bash
    
    # Proxy details
    proxy_address="192.168.x.x"
    proxy_port="3128"
    
    # Target IP and ports
    target_ip="192.168.x.x"
    ports=("22" "80" "443" "3306" "8000" "8080") #Feel free to add additional ports in the same format
    
    # Loop over ports
    for port in "${ports[@]}"; do
        # Make a request using curl with the proxy, and save the response and status code
        response=$(curl -s -o /dev/null -w "%{http_code}" --proxy $proxy_address:$proxy_port $target_ip:$port)
    
        # Check if the status code is 200
        if [ "$response" -eq 200 ]; then
            echo "Response from $target_ip:$port with status code $response"
        fi
    done

### 3) Spose tool 

Link: https://github.com/aancw/spose.git

Scan default common ports

    python3 spose.py --proxy http://TARGET_IP:3128 --target 127.0.0.1

### 4) Access internal services using your browser with FoxyProxy

Create a new proxy, then:

Add the target IP address and port 3128

Now, browse to

    http://TARGET_IP:INTERNAL_PORT

to access the service.
