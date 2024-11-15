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

## TCP Flags

 - tcp-syn TCP SYN (Synchronize)

 - tcp-ack TCP ACK (Acknowledge)

 - tcp-fin TCP FIN (Finish)

 - tcp-rst TCP RST (Reset)

 - tcp-push TCP Push

## Length

 - greater NUM (Or equal)

 - less NUM (Or equal)

## Binary Operations

### A binary operation works on bits, i.e., zeroes and ones. An operation takes one or two bits and returns one bit.

 - | (or)

 - & (and)

 - ! (not)

### Boolean values

 - 0 (False)

 - 1 (True)

## Header Bytes

### Using pcap-filter, Tcpdump allows you to refer to the contents of any byte in the header using the following syntax

 - proto[expr:size[

#### 1) proto refers to the protocol. For example, arp, ether, icmp, ip, ip6, tcp, and udp refer to ARP, Ethernet, ICMP, IPv4, IPv6, TCP, and UDP respectively.

#### 2) expr indicates the byte offset, where 0 refers to the first byte.

#### 3) size indicates the number of bytes that interest us, which can be one, two, or four. It is optional and is one by default.
