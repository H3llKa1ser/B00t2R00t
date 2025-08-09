# Trufflehog

### Use this tool to search for secrets like keys, tokens, etc in github/gitlab repositories, AWS/GCP/Azure storage buckets, etc

### Installation command

    sudo curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sudo sh -s -- -b /usr/local/bin

### Usage

#### 1) Checks for secrets in a gitlab repository

    sudo trufflehog git https://gitlab.com/WHATEVER/REPOSITORY 

#### 2) Checks for secrets in a docker image

    sudo trufflehog docker --image LOCATION-docker.pkg.dev/PROJECT_NAME/REPOSITORY_NAME/PACKAGE_NAME 

