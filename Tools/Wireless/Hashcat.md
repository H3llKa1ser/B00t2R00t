# Hashcat 

## Modules and formats

### 1) hccapx: It is a custom format specifically developed for hashcat for usage on WPA and WPA2

### 2) cap2hccapx: Converts the .cap file to .hccapx and hashcat would be able to bruteforce against it

## Usage:

#### 1) cd /usr/share/hashcat-utils

#### 2) ./cap2hccapx.bin /path/to/HANDSHAKE.cap /path/to/HANDSHAKE.hccapx (Convert the .cap file to the format that hashcat can use)

#### 3) hashcat -m 2500 HANDSHAKE.hccapx WORDLIST.txt --show (-m 2500 = WPA/WPA2 Hashes)
