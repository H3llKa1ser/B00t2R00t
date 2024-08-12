# gcloud GCP CLI tool

## Authentication

 - gcloud auth login (User identity login)

 - gcloud auth activate-service-account --key-file=creds.json (Service account login)

 - gcloud auth list (List accounts available to gcloud)

 - gcloud auth print-access-token (Prints access token. Can be assigned in a variable later on for other purposes)

 - gcloud auth revoke --all (Removes all existing authenticated sessions)

 - gcloud auth configure-docker LOCATION-docker.pkg.dev (Adds credHelper for our gcloud region in the ~/.docker/config.json file to pull docker images)

## Account Information

 - gcloud config list (Get account information)

 - gcloud organizations list (List organizations)

 - gcloud organizations get-iam-policy ORG_ID (Enumerate IAM policies set ORG-wide)

 - gcloud projects get-iam-policy PROJECT_ID (Enumerate IAM policies set per project)

 - gcloud projects get-iam-policy PROJECT_ID > policy.yml (Save the YAML output locally to a .yml file)

 - gcloud projects get-iam-policy PROJECT_ID --format=json (Enumerate IAM policies with JSON format output)

 - gcloud projects list (List projects)

 - gcloud config set project PROJECT_NAME (Set a different project)

 - gloud services list (Gives a list of all APIs that are enabled in project)

## Repositories/Source Reader permissions

 - gcloud source repos list (Get source code repos available to user)

 - gcloud source repos clone REPO_NAME (Clone repo to home dir)

## Virtual Machines

 - gcloud compute instances list (List compute instances)

 - gcloud beta compute ssh --zone "REGION" "INSTANCE_NAME" --project "PROJECT_NAME" (Get shell access to instance)

 - gcloud compute ssh LOCAL_HOST (Puts public ssh key onto metadata service for project)

 - gcloud kms decrypt --ciphertext-file=ENCRYPTED_FILE.enc --plaintext-file=out.txt --key CRYPTO_KEY --keyring CRYPTO_KEYRING --location global (Use Google keyring to decrypt encrypted data)

 - curl http://metadata.google.internal/computeMetadata/v1/instance/serviceaccounts/default/scopes -H &#39;Metadata-Flavor:Google’ (Get access scopes if on an instance)

## Storage Buckets

 - gsutil ls (List Google Storage buckets)

 - gsutil ls -r gs://BUCKET_NAME (List Google Storage buckets recursively)

 - gsutil cp gs://BUCKET_ID/item . (Copy item from bucket)

 - gsutil cp gs://BUCKET_ID/item - (Print the item output in our terminal)

 - gsutil stat gs://BUCKET_ID/index.html (Returns more information about a file)

 - gcloud storage ls gs://BUCKET_ID --project=PROJECT_NAME (List objects stored in a specific bucket within a specific project)

## Webapps and SQL

 - gcloud app instances list (List webapps)

 - gcloud sql instances list (List SQL instances)

 - gcloud spanner instances list

 - gcloud bigtable instances list

 - gcloud sql databases list --instance INSTANCE_ID (List SQL databases)

 - gcloud spanner databases list --instance INSTANCE_NAME

## Export SQL databases and buckets

 - gsutil cp gs://BUCKET_NAME/FOLDER/ . (First copy buckets to local directory)

 - gsutil mb gs://GOOGLE_STORAGE_NAME (Create a new storage bucket)

 - gsutil acl ch -u SERVICE_ACCOUNT gs://GOOGLE_STORAGE_NAME (Change permissions)

 - gcloud sql export sql SQL_INSTANCE_NAME gs://<GOOGLE_STORAGE_NAME/sqldump.gz --database=DATABASE_NAME (Export SQL DB)

## Networking

 - gcloud compute networks list (List networks)

 - gcloud compute networks subnets list (List subnets)

 - gcloud compute vpn-tunnels list (List VPN tunnels)

 - gcloud compute interconnects list (List Interconnects (VPN)

## Containers

 - gcloud container clusters list

### GCP Kubernetes config file ~/.kube/config gets generated when you are authenticated with gcloud and run:

 - gcloud container clusters get-credentials CLUSTER_NAME --region REGION

### If successful and the user has the correct permission the Kubernetes command below can be used to get cluster info:

 - kubectl cluster-info

## Serverless

#### GCP functions log analysis – May get useful information from logs associated with GCP functions

 - gcloud functions list

 - gcloud functions describe FUNCTION_NAME

 - gcloud functions logs read FUNCTION_NAME --limit NUMBER_OF_LINES

### Gcloud stores creds in ~/.config/gcloud/credentials.db Search home directories

 - sudo find /home -name "credentials.db

### Copy gcloud dir to your own home directory to auth as the compromised user

 - sudo cp -r /home/username/.config/gcloud ~/.config

 - sudo chown -R currentuser:currentuser ~/.config/gcloud

 - gcloud auth list

## Secrets

 - gcloud secrets list --project=PROJECT_NAME (List the secrets stored in a project)

 - gcloud secrets versions access latest --secret=SECRET_NAME --project=PROJECT_NAME (Access the secret)

## Service Account Impersonation

 - gcloud config set auth/impersonate_service_account ACCOUNT_NAME_TO_IMPERSONATE@PROJECT_NAME.iam.gserviceaccount.com

 - gcloud config unset auth/impersonate_service_account (ALWAYS USE THIS AT THE END OF EACH ASSESSMENT TO AVOID FUTURE CONFLICTS)

 - gcloud config list (Confirm the account impersonation)

## Artifacts

 - gcloud artifacts repositories list --project=PROJECT_NAME --format="table[box](name, format, mode, LOCATION)" (Enumerate artifact repository)

 - gcloud artifacts packages list --repository REPOSITORY_NAME --location LOCATION (List detailed information about a specific repository)
 
 - gcloud artifacts versions list --repository REPOSITORY_NAME --location LOCATION --package PACKAGE_NAME (List versions of a specific package)

## Identity Access Management IAM

 - gcloud iam service-accounts list --project PROJECT_NAME (List service accounts in a specific project)


