# Enumerate Wireless setup environments

## Commands:

#### 1) Check for Wireless network interfaces
 
    iwconfig 

#### 2) Detailed information and statistics about wireless network interfaces and their configurations

    iw dev 

#### 3) Obtain the BSSID of our target

    wash -i WIRELESS_INTERFACE 

#### 4) Check if we've any pre installed tools that are having capabilities set to perform network related activities. (cap_net_raw+ep)

    getcap -r / 2>/dev/null 

#### 5) Check if we can execute preinstalled tools for network related activities as root

    sudo -l 

#### 6) Check for SUID bit on preinstalled tools

    find / -type f -u=s 2>/dev/null 

#### 7) Scan available Wi-Fi

    iw dev WIRELESS_INTERFACE scan 

    iwlist WIRELESS_INTERFACE scan

## Examples:

#### 1) Master Mode NIC

 - This interface is in master mode, indicating that it is configured as the Access Point (AP).

#### 2) Client Mode NIC (Named ESSID)

 -  This interface is in client mode, confirming that it functions as a Wi-Fi client, connecting to another wireless network.  (AP BSSID)

#### 3) Monitor Mode NIC

 -  This interface is in monitor mode, which is commonly used for wireless network monitoring and testing purposes. It does not participate in regular client or AP activities.

#### 4) Managed Mode NIC

 - Managed mode NICs are usually associated with other networks. This is the standard mode used by most Wi-Fi devices (like laptops, phones, etc.) to connect to Wi-Fi networks. In managed mode, the device acts as a client, connecting to an access point to join a network.
