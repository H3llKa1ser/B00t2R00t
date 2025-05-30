# Enumerate Wireless setup environments

## Commands:
 
 - iwconfig (Check for Wireless network interfaces)

 - iw dev (Detailed information and statistics about wireless network interfaces and their configurations)

 - wash -i WIRELESS_INTERFACE (Obtain the BSSID of our target)

 - getcap -r / 2>/dev/null (Check if we've any pre installed tools that are having capabilities set to perform network related activities.) (cap_net_raw+ep)

 - sudo -l (Check if we can execute preinstalled tools for network related activities as root)

 - find / -type f -u=s 2>/dev/null (Check for SUID bit on preinstalled tools)

 - iw dev WIRELESS_INTERFACE scan (Scan available Wi-Fi)

 - iwlist WIRELESS_INTERFACE scan

## Examples:

#### 1) Master Mode NIC

 - This interface is in master mode, indicating that it is configured as the Access Point (AP).

#### 2) Client Mode NIC (Named ESSID)

 -  This interface is in client mode, confirming that it functions as a Wi-Fi client, connecting to another wireless network.  (AP BSSID)

#### 3) Monitor Mode NIC

 -  This interface is in monitor mode, which is commonly used for wireless network monitoring and testing purposes. It does not participate in regular client or AP activities.

#### 4) Managed Mode NIC

 - Managed mode NICs are usually associated with other networks. This is the standard mode used by most Wi-Fi devices (like laptops, phones, etc.) to connect to Wi-Fi networks. In managed mode, the device acts as a client, connecting to an access point to join a network.
