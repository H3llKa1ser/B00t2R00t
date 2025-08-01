# WiFi Password Recovery

## Requirements: You must already have WiFi and administrator access.

### Windows

### Steps:

#### 1) Run CMD as administrator

#### 2) 

    netsh

#### 3) Show all WiFi networks within range

    netsh> wlan show profile 

#### 4) Dumps everything about the specific WiFi network, including password

    netsh> wlan show profile MY_PROFILE key=clear 
