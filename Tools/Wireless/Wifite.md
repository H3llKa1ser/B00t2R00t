# Wifite

## TIP: Always run with sudo

## Usage:

#### 1) Help page

    wifite -h 

#### 2) Check in which wireless network we are currently connected

    wifite -i wlan0 
    
#### 3) Check for other access points operating on the same specified channel

    wifite -c CHANNEL_NUM, CHANNEL_NUM2 

#### 4) Filter out only the access points with clients connected

    wifite --clients-only 

#### 5) Changes interface from monitor mode to managed (default) mode 

    wifite --daemon 

#### 6) (Find all networks around us that are running on WEP protocol) Press CTRL+C to stop scanning then choose a target. 

    wifite --wep 

## TIP: On step 6, you can conduct a replay attack on the WEP protocol. Does not work on WPA since WPA implements a sequence counter to protect replay attacks.

#### 7) Skip crack option will tell wifite to stop the tool from cracking any handshake it captures. Running wifite without arguments is the default function to scan networks.

    wifite --skip-crack 

#### 8) Filter out a specific attack (PMKID in this case

    wifite --no-pmkid 

#### 9) Scan delay before attacking targets to avoid triggering security mechanisms

    wifite -p SECONDS 

#### 10) Set a timeout delay

    wifite --pmkid-timeout SECONDS 

#### 11) No deauth attack on the target

    wifite -e ESSID --nodeauths 

#### 12) Target WPA networks only

    wifite --wpa 
    
#### 13) Ignore existing handshakes and capture new ones

    wifite --new-hs 

#### 14) Use a custom wordlist

    wifite --dict /PATH/TO/WORDLIST.txt 

#### 15) Display already cracked targets

    wifite --cracked 

#### 16) Validate handshakes

    wifite --check 

#### 17) Crack handshake file

    wifite --crack 

#### 18) Kill conflicting processes that may interfere with the tool

    wifite --kill 

#### 19) MAC Spoofing. Don't forget to check your real MAC with ip a or ifconfig

    wifite --random-mac 

#### 20) Set a decibel frequency threshold

    wifite --power DECIBEL_NUM 
