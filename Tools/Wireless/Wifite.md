# Wifite

## TIP: Always run with sudo

## Usage:

#### 1) wifite -h (Help page)

#### 2) wifite -i wlan0 (Check in which wireless network we are currently connected)

#### 3) wifite -c CHANNEL_NUM,CHENNEL_NUM2 (Check for other access points operating on the same specified channel)

#### 4) wifite --clients-only (Filter out only the access points with clients connected)

#### 5) wifite --daemon (Changes interface from monitor mode to managed (default) mode )

#### 6) wifite --wep (Find all networks around us that are running on WEP protocol) Press CTRL+C to stop scanning then choose a target. 

## TIP: On step 6, you can conduct a replay attack on the WEP protocol. Does not work on WPA since WPA implements a sequence counter to protect replay attacks.

#### 7) wifite --skip-crack (Skip crack option will tell wifite to stop the tool from cracking any handshake it captures. Running wifite without arguments is the default function to scan networks.)

#### 8) wifite --no-pmkid (Filter out a specific attack (PMKID in this case)

#### 9) wifite -p SECONDS (Scan delay before attacking targets to avoid triggering security mechanisms)

#### 10) wifite --pmkid-timeout SECONDS (Set a timeout delay)

#### 11) wifite -e ESSID --nodeauths (No deauth attack on the target)

#### 12) wifite --wpa (Target WPA networks only)

#### 13) wifite --new-hs (Ignore existing handshakes and capture new ones)

#### 14) wifite --dict /PATH/TO/WORDLIST.txt (Use a custom wordlist)

#### 15) wifite --cracked (Display already cracked targets)

#### 16) wifite --check (Validate handshakes)

#### 17) wifite --crack (Crack handshake file)

#### 18) wifite --kill (Kill conflicting processes that may interfere with the tool)

#### 19) wifite --random-mac (MAC Spoofing. Don't forget to check your real MAC with ip a or ifconfig)

#### 20) wifite --power DECIBEL_NUM (Set a decibel frequency threshold)
