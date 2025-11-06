# Server Message Block (SMB)

Port: 445, 139 (NetBIOS)

## Enumeration: Hostname

#### 1) nmblookup

    nmblookup -A IP

Useful information:

For unique names:

00: Workstation Service (workstation name)
03: Windows Messenger service
06: Remote Access Service
20: File Service (also called Host Record)
21: Remote Access Service client
1B: Domain Master Browser – Primary Domain Controller for a domain
1D: Master Browser

For group names:

00: Workstation Service (workgroup/domain name)
1C: Domain Controllers for a domain
1E: Browser Service Elec􀆟ons

#### 2) Nbtscan

    nbtscan IP

#### 3) Nmap

    sudo nmap --script nbtstat.nse IP
    sudo nmap --script smb-os-discovery 192.168.1.17
    
#### 4) Nbtstat

    nbtstat -A IP

#### 5) Ping

    ping -a IP

## Enumeration: Share and Null Session

#### 1) Smbmap

    smbmap -H IP

    smbmap -H IP -u USER -p PASSWORD

#### 2) Smbclient

    smbclient -L IP

    smbclient //IP/GUEST
    get file.txt

Authenticated enumeration

    smbclient -L IP -U USER%PASSWORD

    smbclient //IP/SHARE -U USER%PASSWORD
    get file.txt

#### 3) Nmap

    sudo nmap --script smb-enum-shares -p139,445 IP
    sudo nmap --script smb-vuln* 192.168.1.16

#### 4) Net view (Windows)

    net view \\IP /All

#### 5) Metasploit

    use auxiliary/scanner/smb/smb_enumshares
    set rhosts RHOST
    set smbuser USER
    set smbpass PASS
    exploit

#### 6) Netexec

    netexec smb IP -u 'USER' -p 'PASSWORD' --shares

#### 7) Rpcclient

    rpcclient -U "" -N IP

    rpcclient $> netshareenum
    rpcclient $> netshareenumall

## Enumeration: Users

#### 1) Metasploit

    use auxiliary/scanner/smb/smb_lookupsid
    set rhosts RHOST
    set smbuser USER
    set smbpass PASS
    exploit

#### 2) Impacket Lookupsid

    impacket-lookupsid DOMAIN/USER:PASSWORD@IP

## Extra: Enum4linux-ng

    enum4linux-ng IP

## Network Packet Analysis

    sudo ngrep -i -d INTERFACE 's.?a.?m.?b.?a.*[[:digit:]]' port 139

