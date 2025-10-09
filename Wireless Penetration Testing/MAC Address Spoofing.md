# MAC Address Spoofing

Use case: Disguise your device or bypass certain network filters.

## Commands

#### 1) Deactivate your wireless interface

    sudo ifconfig wlan0 down

#### 2) Change your MAC address on your wireless interface

    sudo ifconfig wlan0 hw ether 00:11:22:33:44:55

#### 3) Activate your wireless interface

    sudo ifconfig wlan0 up

The above commands temporarily change your MAC address. Replace wlan0 with your interface name and 00:11:22:33:44:55 with the desired MAC address.
