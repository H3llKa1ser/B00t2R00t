# Docker Registry

## Tools: Postman, Insomnia, Browsers, drg.py https://github.com/Syzik/DockerRegistryGrabber

### Default port: 5000 (Not always the case)

#### Docker registries are JSON endpoitns, so the interaction is quite different from a normal website.

####

## REPOSITORY DISCOVERY

### We may find plain text credentials or any other sensitive information of outdated repositories that haven't been taken down yet. So we can just get them via a GET request.

## EXAMPLE:

#### 1) List repositories

    curl http://IP_ADDRESS:5000/v2/_catalog 

#### 2) List manifests

    curl http://IP_ADDRESS:5000/v2/REPOSITORY/tags/list 

#### 3) Pull the manifests for the image

    curl http://IP_ADDRESS:5000/v2/REPOSITORY/manifests/latest 

#### On step 3 you can also check for any clear-text credentials for a database or ssh etc.

#### 4) Pull all layers of the image and save them in the form of .tar file

    curl -s http://IP_ADDRESS:5000/v2/REPOSITORY/blobs/sha256:HASH -output ARCHIVE.tar 

#### 5) Decompress the file to see the contents

    tar -xvf ARCHIVE.tar 
