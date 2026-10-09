# Reconnaissance

### 1) Check if Wireless interfaces are present 

    sudo iw dev

### 2) Identify what is running

    sudo airmon-ng check

### 3) Kill any interfering processes

    sudo airmon-ng check kill

### 4) Enable Monitor Mode

    sudo airmong-ng start wlan0

### 5) Confirm changes

Check for: Type monitor

    sudo iw dev

### 6) Sweep on 2.4 GHz band

    sudo airodump-ng --band bg wlan0mon

Sweep every single band (both 2.4 GHz and 5 GHz)

    sudo airodump-ng --band abg wlan0mon

## Information meaning

| Column  | Meaning                                                                                                                                                                                                                                                                                                                                                                 |
|---------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| BSSID   | The MAC address of the AP's radio, the unique identifier for one specific access point.                                                                                                                                                                                                                                                                                 |
| PWR     | Signal strength (in dBm). Closer to 0 is stronger. About -30 dBm is adjacent; around -70 dBm is distant. Useful for physically locating an AP.                                                                                                                                                                                                                          |
| RXQ     | Receive quality: percentage of frames from this AP that arrived intact over the last few seconds. Appears only when using `-c` to pin the radio to a single channel; hopping scans don’t listen long enough to measure it. Many rows show 0 while their beacon count climbs—this indicates no measurement, not a bad link; interpret alongside Beacons rather than alone.                                     |
| Beacons | Count of beacon frames broadcast by this AP since the scan started. A steadily climbing count means a live, nearby AP.                                                                                                                                                                                                                                                  |
| #Data   | Captured data frames. A busy network indicates where the users are.                                                                                                                                                                                                                                                                                                      |
| #/s     | Data frames captured per second over the last few seconds.                                                                                                                                                                                                                                                                                                               |
| CH      | The channel the AP is operating on.                                                                                                                                                                                                                                                                                                                                      |
| MB      | The maximum speed the AP advertises (e.g., 54). A trailing `.` or `e` denotes short preamble / QoS support.                                                                                                                                                                                                                                                             |
| ENC     | The encryption family: `OPN`, `WEP`, `WPA`, `WPA2`, or `WPA3`.                                                                                                                                                                                                                                                                                                           |
| CIPHER  | The cipher in use: `CCMP` (modern, AES-based), `TKIP` (legacy), or `WEP`.                                                                                                                                                                                                                                                                                                |
| AUTH    | How clients authenticate: `PSK` (pre-shared key), `SAE` (WPA3), `MGT` (enterprise / 802.1X), or `OWE`.                                                                                                                                                                                                                                                                  |
| ESSID   | The network name. If blank or shown as `<length: N>`, the network is hidden.                                                                                                                                                                                                                                                                                             |

### 7) Sweep in 5 GHz band on a specific channel (recommended for corporate recon)

    sudo airodump-ng --band a -c NUM wlan0mon

### 8) Once a target is identified, capture a single network for a 4-Way handshake

    sudo airodump-ng -c NUM --bssid BSSID_NUM -w CAPTURE_FILE_WRITE wlan0mon

## Determine which attacks are applicable to each network

| Value        | Column | Meaning                                                                                                   |
|--------------|--------|-----------------------------------------------------------------------------------------------------------|
| `OPN`        | ENC    | Open network, no encryption at all.                                                                       |
| `WEP`        | ENC    | Legacy, thoroughly broken encryption — treat as open.                                                     |
| `WPA2 + PSK` | ENC/AUTH | “Personal” WPA2 with a single shared password; the classic handshake‑capture target.                   |
| `WPA3 + SAE` | ENC/AUTH | WPA3‑Personal using the SAE handshake; resistant to offline cracking.                                  |
| `OWE`        | AUTH   | Open network with encryption: no password, but traffic is protected.                                      |
| `MGT`        | AUTH   | Enterprise / 802.1X: per‑user credentials validated against a central authentication server (RADIUS).     |

## Reveal hidden networks

Identified as an empty ESSID field.

### 1) Lock the monitor interface to the target's channel

    sudo iw dev wlan0mon set channel TARGET_NUM

### 2) Probe the hidden BSSID with a wordlist

    sudo mdk4 wlan0mon p -t BSSID -f /home/user/wordlists/ssid-names.txt

### 3) Join the network

    cat > staff.conf <<EOF
    network={
        ssid="Staff-Net"
        scan_ssid=1
        key_mgmt=NONE
    }
    EOF

Then

    sudo wpa_supplicant -B -i wlan1 -c staff.conf

And

    sudo iw dev wlan1 link

### 4) Request an address

    sudo dhclient -v wlan1

### 5) Login to router interface

    curl -s -c cookies.txt -d "Username=admin&Password=admin&Submit=Submit" http://192.168.16.1/login.php -o /dev/null

Interact with your newly created session via CLI

    curl -s -b cookies.txt http://192.168.16.1/index.php

## Recon organizing

### 1) Save captures to disk

    sudo airodump-ng --bssid BSSID -c NUM -w CAPTURE_FILE wlan0mon

Files produced by a capture have these suffixes:

    .cap, .csv, .kismet.csv, .kismet.netxml, .log.csv

### 2) Specify which output format type should be written

    sudo airodump-ng --output-format csv --bssid BSSID -c NUM -w CAPTURE_FILE wlan0mon

    


