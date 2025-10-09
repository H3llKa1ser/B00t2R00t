# Fake Authentication Attack

Before cracking WEP, you may need to authenticate with the network using a fake request.

## Commands

#### 1) Sends a fake authentication request

    aireplay-ng -1 0 -e SSID -a BSSID -h MAC wlan0mon

You send a fake authentication request to the network to start capturing packets.
