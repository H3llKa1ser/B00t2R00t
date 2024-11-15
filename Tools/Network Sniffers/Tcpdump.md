# Tcpdump CLI network sniffer

## TIP: Capturing packets can only be done as ROOT! (Sudo)

## Commands:

 - tcpdump -i INTERFACE (Captures packets on a specific network interface)

 - tcpdump -w FILE (Writes captured packets to a file)

 - tcpdump -r FILE	(Reads captured packets from a file)

 - tcpdump -c COUNT	(Captures a specific number of packets)

 - tcpdump -n	(Don’t resolve IP addresses)

 - tcpdump -nn	(Don’t resolve IP addresses and don’t resolve protocol numbers)

 - tcpdump -v	(Verbose display; verbosity can be increased with -vv and -vvv)

 - tcpdump -i any -nn (Captures packets on all interfaces and displays them on screen without domain name or protocol resolution.)

## Filters:

### Hosts

 - src host IP or src host HOSTNAME (Capture packets only from source ip/hostname)

 - dst host IP or dst host HOSTNAME (Capture packets only from destination ip/hostname)

### Ports

 - src port NUM (Capture packets only from source port number)

 - dst port NUM (Capture packets only from destination port number)

### Protocols

 - ip

 - ip6

 - arp

 - tcp

 - udp

 - icmp

## Logical Operators

 - and

 - or

 - not
