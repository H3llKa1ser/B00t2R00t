# John The Ripper (JtR)

## Usage:

#### 1) Creates a john hash file 

    hcxpcapngtool --john hash.john HANDSHAKE.cap 

#### 2) Converts the .cap file to .hccapx file

    hcxpcapngtool -o HANDHSAKE.hccapx HANDSHAKE.cap 

#### 3) Crack the password

    john --format=wpapsk --wordlist WORDLIST.txt hash.john

#### 4) 

    john --show hash.john 

## Second method

#### 1) 

    hccap2john HANDSHAKE.hccapx > wifihash

#### 2) 

    john --wordlist=/PATH/TO/WORDLIST.txt --format=wpapsk wifihash (Crack the password)
