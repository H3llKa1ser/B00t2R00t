# WiFi Password Recovery

## Requirements: You must already have WiFi and administrator access.

### Windows

#### Steps:

 - Run CMD as administrator

 - netsh

 - netsh> wlan show profile (Show all WiFi networks within range)

 - netsh> wlan show profile MY_PROFILE key=clear (Dumps everything about the specific WiFi network, including password)
