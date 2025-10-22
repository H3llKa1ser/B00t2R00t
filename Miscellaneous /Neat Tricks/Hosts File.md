# Hosts File

Tool: https://github.com/eMVee-NL/UpdateHostsFile

Resolves all ips to fqdn within the network based on protocols and adds entry within /etc/hosts to not add them manually.

## Usage

### 1) Clone project to your machine

    git clone https://github.com/eMVee-NL/UpdateHostsFile

### 2) Run the script to resolve IPs to FQDN

    sudo python Update-Hosts-File.py --protocols smb,rdp --subnet 192.168.130.0/24
    sudo python Update-Hosts-File.py --protocols smb,rdp --subnet 172.16.130.0/24

#### TIP: This will not create domain entries for domain controllers.
