# John The Ripper (JtR)

## Usage:

#### 1) hcxpcapngtool --john hash.john HANDSHAKE.cap (Creates a john hash file )

#### 2) hcxpcapngtool -o HANDHSAKE.hccapx HANDSHAKE.cap (Converts the .cap file to .hccapx file)

#### 3) john --format=wpapsk --wordlist WORDLIST.txt hash.john

#### 4) john --show hash.john (Crack the password)

## Second method

#### 1) hccap2john HANDSHAKE.hccapx > wifihash

#### 2) john --wordlist=/PATH/TO/WORDLIST.txt --format=wpapsk wifihash (Crack the password)
