# Icmptunnel (ICMP Tunneling)

## Github repo: https://github.com/jamesbarlow/icmptunnel

### Installation

 - git clone https://github.com/jamesbarlow/icmptunnel.git

 - cd icmptunnel
 
 - make

### Disable ICMP echo reply

 -echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all

 - ./icmptunnel -s

 - Ctrl+z

 - bg

### Start the ICMP tunnel on server mode and assign it a new IP address for tunneling 

 - /sbin/ifconfig tun0 10.0.0.1 netmask 255.255.255.0

 - ifconfig

### Now do the same for Kali Linux and then SSH to your target

### Now all SSH traffic is being transmitted via ICMP
