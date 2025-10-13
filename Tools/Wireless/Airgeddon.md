# Airgeddon

### Installation

    git clone https://github.com/v1s1t0r1sh3r3/airgeddon.git
    cd airgeddon
    sudo ./airgeddon.sh

Upon installation, choose your wireless interface (wlan0, for example)

Put your Wi-Fi card in monitor mode.

### Capture Handshake and Deauthentication

Airgeddon uses numbers to choose any Wifi attacks as they are largely automated by the tool.

Numbers to choose:

    5
    6

After getting the target's AP, press

    CTRL+C

It will display a list of all ESSIDs (Wi-Fi names) examined, as well as their BSSID (MAC Address) and ENC encryption protocol type. Then, as we did for ESSID "test," you can pick your target by supplying a Serial Number.

#### NOTE: The asterisks (*) indicate client access points; they are maybe the best "clients" for acquiring handshakes. Any Access Point that implements the WEP ENC protocol will be ignored by Airgeddon.

### Deauthentication attack

Choose option:

    2
    1-100 (Select timeout period)

Store this .cap file locally to crack it.

### Aircrack dictionary attack for WPA handshake

Return to main menu

    0

Select option

    6
    1

Then,

    1
    Y
    Y
    /usr/share/wordlists/rockyou.txt

If all goes well, the password should have been cracked.

### Aircrack Brute-force attack for WPA handshake

Options

    2
    Y
    Y
    8-63
    8-63

### Hashcat Rule-Based attack for WPA Handshake

Options

    5
    /path/to/handshake.cap
    /usr/share/wordlists/rockyou.txt
    /usr/share/hashcat/rules/best64.rule

### Evil Twin Attack

An evil twin is a forgery of a Wi-Fi access point (Bogus AP) that masquerades as genuine but is purposefully set up to listen in on wireless traffic. By creating a fake website and enticing people to it, this type of attack can be used to obtain credentials from the legitimate clients.

Select options

    7
    9

Scans WPA/WPA2 access points, then select your target AP.

Select options

    2
    y
    N
    20

Capture the WPA handshake

    /home/user/handshake.cap

Save captured credentials by the captive portal

    /home/user/creds.txt

Set up the captive portal

Choose language

    1 (English)

#### Note: Do not close the windows; they will dissipate a􀅌er the password has been captured.

All clients connecting to the original AP will be disconnected, and when they attempt to reconnect, they will discover two APs with the same name. When the client connects to the bogus AP, it is lured to the cap􀆟ve portal.

The captive web portal will ask to submit the Wi-Fi password key to get internet access.

If the client gives the Wi-Fi key, the password will be captured in plaintext in the control window.

Additionally, save the password in the file you gave during the proposal.
