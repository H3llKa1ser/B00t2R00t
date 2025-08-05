# Docker Container Creation and Deployment

## Create and deploy containers with docker for testing various exploits without having to modify your host environment

### Steps:

#### 1) Write a dockerfile containing details like OS, distribution, setting up environment variables, running commands to install packages and transfer files from host environment to container and vice-versa

#### 2) Create the container

    docker build -t CONTAINER_NAME:v1 .

#### 3) Run bash on the container to gain root shell

    docker run -it --rm tfrce:v1 bash
