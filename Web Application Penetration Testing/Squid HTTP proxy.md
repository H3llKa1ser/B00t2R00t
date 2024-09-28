## Squid HTTP proxy pentesting

## Tool: https://github.com/aancw/spose.git

### Default port: 3128

### Enumeration:

#### 1) cURL

#### curl --proxy http://TARGET_IP:3128 http://TARGET_IP (You can set this doscovered service as proxy in your browser. However, if it is configured with HTTP authentication, you will be prompted for usernames and password.)

#### 2) Proxyfied nmap

#### Configure proxychains to use the squid proxy by adding the following line at the end of proxyhchains.conf file:

#### http  TARGET_IP 3128

#### sudo proxychains nmap -sT -p- -n localhost (Scan for internal ports by using the squid proxy)

### Exposed squid proxy can be used to gain access to internal applications or ssh connections
