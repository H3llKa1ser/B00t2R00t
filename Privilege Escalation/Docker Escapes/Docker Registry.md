# DOCKER REGISTRY

## Tools: Postman, Insomnia, Browsers

### Default port: 5000 (Not always the case)

#### Docker registries are JSON endpoitns, so the interaction is quite different from a normal website.

####

## REPOSITORY DISCOVERY

### We may find plain text credentials or any other sensitive information of outdated repositories that haven't been taken down yet. So we can just get them via a GET request.

## EXAMPLE:

#### 1) curl http://IP_ADDRESS:5000/v2/_catalog

#### 2) curl http://IP_ADDRESS:5000/v2/REPOSITORY/tags/list

#### 3) curl http://IP_ADDRESS:5000/v2/REPOSITORY/manifests/latest (Pull the manifests for the image)

#### 4) curl -s http://IP_ADDRESS:5000/v2/REPOSITORY/blobs/sha256:HASH -output ARCHIVE.tar (Pull all layers of the image and save them in the form of .tar file)
