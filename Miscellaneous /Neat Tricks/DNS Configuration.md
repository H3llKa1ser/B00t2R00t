# DNS Configuration

## Files

- /etc/resolv-dnspasq

- /etc/hosts

### 1) Edit /etc/resolv-dnsmasq file

    sudo nano /etc/resolv-dnsmasq

Contents

    nameserver DNS_SERVER_IP
    nameserver 169.254.169.253

Restart dnsmasq service

    /etc/init.d/dnsmasq restart

 ### 2) Edit /etc/hosts file

     sudo nano /etc/hosts

  Contents

    127.0.0.1	localhost
    127.0.0.1   vnc.example.tech
    127.0.1.1	example.lan	example
    
    # The following lines are desirable for IPv6 capable hosts
    ::1     localhost ip6-localhost ip6-loopback
    ff02::1 ip6-allnodes
    ff02::2 ip6-allrouters
    TARGET_IP example.com

