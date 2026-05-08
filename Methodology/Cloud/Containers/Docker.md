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

    docker rin -i -t DIRECTORY/IMAGE:latest /bin/bash

### 9) Inspect image contents like environmental variables

    docker inspect DIRECTORY/IMAGE:latest

