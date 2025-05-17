# Network Sniffing

## Description

Adversaries may sniff network traffic to capture information about an environment, including authentication material passed over the network. Network sniffing refers to using the network interface on a system to monitor or capture information sent over a wired or wireless connection. An adversary may place a network interface into promiscuous mode to passively access data in transit over the network, or use span ports to capture a larger amount of data.

Data captured via this technique may include user credentials, especially those sent over an insecure, unencrypted protocol. Techniques for name service resolution poisoning, such as LLMNR/NBT-NS Poisoning and SMB Relay, can also be used to capture credentials to websites, proxies, and internal systems by redirecting traffic to an adversary.

Network sniffing may also reveal configuration details, such as running services, version numbers, and other network characteristics (e.g. IP addresses, hostnames, VLAN IDs) necessary for subsequent Lateral Movement and/or Defense Evasion activities.

## Techniques

### 1) Empire C2

    powershell/collection/packet_capture

After capture has been stopped the capture.etl file can be converted to a PCAP with etl2pcapng (Windows required).

Link: https://github.com/microsoft/etl2pcapng/releases

After converting to PCAP we are able to view the results in Wireshark.

### 2) Metasploit

##### Meterpreter 

    use sniffer
    sniffer_interfaces
    sniffer_start <ID>
    sniffer_dump <ID> /tmp/sniff.pcap
    sniffer_stop <ID>
    sniffer_release <ID>

### 3) Netsh

##### Start trace

    netsh trace start capture=yes tracefile=C:\Windows\Temp\trace.etl maxsize=10

##### Stop trace

    netsh trace stop

After capture has been stopped the capture.etl file can be converted to a PCAP with etl2pcapng (Windows required).

Link: https://github.com/microsoft/etl2pcapng/releases

After converting to PCAP we are able to view the results in Wireshark.

### 4) Pktmon

    pktmon.exe start --etw  -f %TEMP%\t1040.etl
    TIMEOUT /T 5 >nul 2>&1
    pktmon.exe stop

##### Filter by port

    pktmon.exe filter add -p 445

##### Remove filter

    pktmon.exe filter remove

    pktmon etl2txt t1040.etl --out t1040.txt

Or the .etl file can be opened directly in event viewer.

