# Wifipumpkin3

## Features

- Rogue access point attack

- Man-in-the-middle attack

- Module for deauthentication attack

- Module for extra-captiveflask templates

- Rogue DNS Server

- Captive portal attack (captiveflask)

- Intercept, inspect, modify and replay web traffic

- WiFi networks scanning

- DNS monitoring service

- Credentials harvesting

- Transparent Proxies

- LLMNR, NBT-NS, and MDNS poisoner

## Installation

#### 1) Install dependencies

    sudo apt install libssl-dev libffi-dev build-essential

#### 2) Download the tool and install the rest of the dependencies

    git clone https://github.com/P0cL4bs/wifipumpkin3.git
    cd wifipumpkin3
    sudo apt install python3-pyqt5

Then,

    python3 setup.py install

#### 3) Create a fake access point with the name of "Free wifi" to do Man-in-the-Middle attacks

Run the tool

    sudo wifipumpkin3

Set up your tool

    set interface wlan0
    set ssid Free Wifi
    set proxy noproxy
    ignore pydns_server
    start

Then, when the victim connects to our fake AP, he will receive a malicious IP from our DHCP server.

When a victim connects to an HTTP website that does not have SSL/TLS encryption in transit and inserts data in user input textbox like "username, password, email" for example, Wifipumpkin captures traffic and the credentials entered by the victim in plain text.

#### 4) Captive portal attack

Similar to the first attack, but this time it uses a secure page where the victim must enter credentials (username and password) for the Wi-Fi. Can be used when we are doing an evil twin attack.

Run your tool

    sudo wifipumpkin3

Set up your tool

    set interface wlan0
    set ssid Hotspot
    set proxy captiveflask true
    ignore pydns_server
    start

When the victim connects to our "Hotspot" wifi, he will be redirected to a login page to enter credentials before he can use the internet.

Credentials have been captured by Wifipumpkin and displayed in a table form.

#### 5) Custom Captiveflask
