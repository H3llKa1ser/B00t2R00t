# gcloud GCP CLI tool

## Authentication

#### 1) User Identity Login

    gcloud auth login 

#### 2) Service Account Login

    gcloud auth activate-service-account --key-file=creds.json 

#### 3) List accounts available to gcloud

    gcloud auth list 

#### 4) Prints access token. Can be assigned in a variable later on for other purposes

    gcloud auth print-access-token 

#### 5) Removes all existing authenticated sessions

    gcloud auth revoke --all 

#### 6) Adds credHelper for our gcloud region in the ~/.docker/config.json file to pull docker images

    gcloud auth configure-docker LOCATION-docker.pkg.dev 

## Account Information

#### 1) Get account information

    gcloud config list 

#### 2) List organizations

    gcloud organizations list 

#### 3) Enumerate IAM policies set ORG-wide

    gcloud organizations get-iam-policy ORG_ID 

#### 4) Enumerate IAM policies set per project

    gcloud projects get-iam-policy PROJECT_ID 

#### 5) Save the YAML output locally to a .yml file

    gcloud projects get-iam-policy PROJECT_ID > policy.yml 

#### 6) Enumerate IAM policies with JSON format output

    gcloud projects get-iam-policy PROJECT_ID --format=json 

#### 7) List projects

    gcloud projects list 

#### 8) Set a different project

    gcloud config set project PROJECT_NAME 

#### 9) Gives a list of all APIs that are enabled in project

    gcloud services list 

## Repositories/Source Reader permissions

#### 1) Get source code repos available to user

    gcloud source repos list 

#### 2) Clone repo to home dir

    gcloud source repos clone REPO_NAME 

## Virtual Machines

#### 1) List compute instances

    gcloud compute instances list 

#### 2) Get shell access to instance

    gcloud beta compute ssh --zone "REGION" "INSTANCE_NAME" --project "PROJECT_NAME" 

#### 3) Puts public ssh key onto metadata service for project

    gcloud compute ssh LOCAL_HOST 

#### 4) Use Google keyring to decrypt encrypted data

    gcloud kms decrypt --ciphertext-file=ENCRYPTED_FILE.enc --plaintext-file=out.txt --key CRYPTO_KEY --keyring CRYPTO_KEYRING --location global 

#### 5) Get access scopes if on an instance

    curl http://metadata.google.internal/computeMetadata/v1/instance/serviceaccounts/default/scopes -H &#39;Metadata-Flavor:Google’ 

## Storage Buckets

#### 1) List Google Storage buckets

    gsutil ls 

#### 2) List Google Storage buckets recursively

    gsutil ls -r gs://BUCKET_NAME 

#### 3) Copy item from bucket

    gsutil cp gs://BUCKET_ID/item . 

#### 4) Print the item output in our terminal

    gsutil cp gs://BUCKET_ID/item - 

#### 5) Returns more information about a file

    gsutil stat gs://BUCKET_ID/index.html 

#### 6) List objects stored in a specific bucket within a specific project

    gcloud storage ls gs://BUCKET_ID --project=PROJECT_NAME 

## Webapps and SQL

#### 1) List webapps

    gcloud app instances list 

#### 2) List SQL instances

    gcloud sql instances list 

    gcloud spanner instances list

    gcloud bigtable instances list

#### 3) List SQL databases

    gcloud sql databases list --instance INSTANCE_ID 

    gcloud spanner databases list --instance INSTANCE_NAME

## Export SQL databases and buckets

#### 1) First copy buckets to local directory

    gsutil cp gs://BUCKET_NAME/FOLDER/ . 

#### 2) Create a new storage bucket

    gsutil mb gs://GOOGLE_STORAGE_NAME 

#### 3) Change permissions

    gsutil acl ch -u SERVICE_ACCOUNT gs://GOOGLE_STORAGE_NAME 

#### 4) Export SQL DB

    gcloud sql export sql SQL_INSTANCE_NAME gs://<GOOGLE_STORAGE_NAME/sqldump.gz --database=DATABASE_NAME 

## Networking

#### 1) List networks

    gcloud compute networks list 

#### 2) List subnets

    gcloud compute networks subnets list 

#### 3) List VPN tunnels

    gcloud compute vpn-tunnels list 

#### 4) List Interconnects (VPN)

    gcloud compute interconnects list 

## Containers

#### 1)

    gcloud container clusters list

### GCP Kubernetes config file ~/.kube/config gets generated when you are authenticated with gcloud and run:

    gcloud container clusters get-credentials CLUSTER_NAME --region REGION

### If successful and the user has the correct permission the Kubernetes command below can be used to get cluster info:

    kubectl cluster-info

## Serverless

#### GCP functions log analysis – May get useful information from logs associated with GCP functions

    gcloud functions list

    gcloud functions describe FUNCTION_NAME

    gcloud functions logs read FUNCTION_NAME --limit NUMBER_OF_LINES

### Gcloud stores creds in ~/.config/gcloud/credentials.db Search home directories

    sudo find /home -name "credentials.db

### Copy gcloud dir to your own home directory to auth as the compromised user

    sudo cp -r /home/username/.config/gcloud ~/.config

    sudo chown -R currentuser:currentuser ~/.config/gcloud

    gcloud auth list

## Secrets

#### 1) List the secrets stored in a project

    gcloud secrets list --project=PROJECT_NAME 

#### 2) Access the secret

    gcloud secrets versions access latest --secret=SECRET_NAME --project=PROJECT_NAME 

## Service Account Impersonation

    gcloud config set auth/impersonate_service_account ACCOUNT_NAME_TO_IMPERSONATE@PROJECT_NAME.iam.gserviceaccount.com

    gcloud config unset auth/impersonate_service_account (ALWAYS USE THIS AT THE END OF EACH ASSESSMENT TO AVOID FUTURE CONFLICTS)

    gcloud config list (Confirm the account impersonation)

## Artifacts

#### 1) Enumerate artifact repository

    gcloud artifacts repositories list --project=PROJECT_NAME --format="table[box](name, format, mode, LOCATION)" 

#### 2) List detailed information about a specific repository

    gcloud artifacts packages list --repository REPOSITORY_NAME --location LOCATION

#### 3) List versions of a specific package
   
    gcloud artifacts versions list --repository REPOSITORY_NAME --location LOCATION --package PACKAGE_NAME 

## Identity Access Management IAM

#### 1) List service accounts in a specific project

    gcloud iam service-accounts list --project PROJECT_NAME 

#### 2) List permissions and roles assigned on a specific user
 
    gcloud iam service-accounts get-iam-policy ACCOUNT_NAME@PROJECT_NAME.iam.gserviceaccount.com 

#### 3) Check the permissions granted by this role

    gcloud iam roles describe ROLE --project=PROJECT_NAME 




