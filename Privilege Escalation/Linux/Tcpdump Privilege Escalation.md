# Tcpdump Privilege Escalation

## Requirements:

Sudo 

https://gtfobins.github.io/gtfobins/tcpdump/

Capabilities: cap_net_admin,cap_net_raw+eip

### 1) If we find an interesting process that runs in the background, we can sniff traffic for cleartext credentials

    tcpdump -i any port PORT -w network_traffic.pcap

### 2) Leave it for a few minutes

### 3) Transfer the .pcap file, then analyse traffic with Wireshark

    wireshark -r network_traffic.pcap

