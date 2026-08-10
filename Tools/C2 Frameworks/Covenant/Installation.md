# Covenant C2 - Installation

### 1) Clone repository

    git clone --recurse-submodules https://github.com/cobbr/Covenant

### 2) Installation

Docker

    cd Covenant/Covenant
    docker build -t covenant .

### 3) Launch 

Docker

    docker run -it -p 7443:7443 -p 80:80 -p 443:443 --name covenant -v /root/Covenant/Covenant/Data:/app/Data covenant

