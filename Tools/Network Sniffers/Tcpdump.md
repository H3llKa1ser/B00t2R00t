# Tcpdump CLI network sniffer

## TIP: Most commands run ONLY on sudo

### Commands:

 - tcpdump -i INTERFACE (Captures packets on a specific network interface)

 - tcpdump -w FILE (Writes captured packets to a file)

 - tcpdump -r FILE	(Reads captured packets from a file)

 - tcpdump -c COUNT	(Captures a specific number of packets)

 - tcpdump -n	(Don’t resolve IP addresses)

 - tcpdump -nn	(Don’t resolve IP addresses and don’t resolve protocol numbers)

 - tcpdump -v	(Verbose display; verbosity can be increased with -vv and -vvv)

 - tcpdump -i any -nn (Captures packets on all interfaces and displays them on screen without domain name or protocol resolution.)


