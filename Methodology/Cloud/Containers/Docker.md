# Docker

## Enumeration

### 1) Search in Docker Hub

https://hub.docker.com/search

### 2) Login into the registry

    docker login

### 3) Search for registries

    docker search REGISTRY_NAME

### 4) Get information about the tags

    curl https://hub.docker.com/v2/repositories/DIRECTORY/IMAGE/tags | jq

### 5) Pull image from registry

    docker pull DIRECTORY/IMAGE:latest

### 6) Check details of an image

Install scout docker plugin

    curl -fsSL https://raw.githubusercontent.com/docker/scout-cli/main/install.sh -o install-scout.sh
    sh install-scout.sh

Run command

    docker scout quickview

### 7) Scan image for vulnerabilities

    docker scout cves DIRECTORY/IMAGE:latest

### 8) Interact with a container from this image

    docker run -i -t DIRECTORY/IMAGE:latest /bin/bash

### 9) Inspect image contents like environmental variables

    docker inspect DIRECTORY/IMAGE:latest

## Build and run an image (AKA Dockerize tools)

### 1) Create Dockerfile

Example Dockerfile

    FROM python:3.8
    
    RUN git clone https://github.com/RhinoSecurityLabs/GCPBucketBrute.git
    WORKDIR /GCPBucketBrute
    RUN pip3 install -r requirements.txt
    
    ENTRYPOINT ["python3",  "gcpbucketbrute.py"]

### 2) Create an image (Requires Dockerfile)

    docker build . -t IMAGE_NAME

### 3) Run image

    docker run --rm -v /tmp:/tmp -it IMAGE_NAME [OPTIONAL_ARGUMENTS_ACCORDING_TO_TOOL_NAME]
