# Enumeration

Tools:

1) iam-policy-visualize https://github.com/hac01/iam-policy-visualize

2) graphviz (sudo apt install)

3) GCPBucketBrute https://github.com/RhinoSecurityLabs/GCPBucketBrute

4) gcp-iam-brute https://github.com/hac01/gcp-iam-brute

5) google-workspace-enum https://github.com/pwnedlabs/google-workspace-enum

## IAM Policies

### 1) Save output into a JSON file

    gcloud projects get-iam-policy PROJECT_NAME --format=json > project.json

### 2) Run script

    python3 main.py project.json

## Buckets

### 1) Enumerate buckets

    python3 gcpbucketbrute.py -f /tmp/token.json -k KEYWORD -s 10 -o output.log

## IAM

### 1) Enumerate IAM permissions

    python3 main.py --access-token $(gcloud auth print-access-token) --project-id $(gcloud config get-value project) --service-account-email $(gcloud auth list --filter=status:ACTIVE --format="value(account)")

## Google Workspace

### Prerequisites

- You must use your own Google Cloud project (something you own and control).

- Enable all the APIs mentioned on the official GitHub setup page of the tool google-workspace-enum.

### 1) Create OAuth credentials

Log in to your Google Cloud console and navigate to the Credentials page.

Click on the Create Credentials button.

<img width="1920" height="765" alt="image" src="https://github.com/user-attachments/assets/1cc8565d-36b3-4306-9721-f83d567cd98e" />

### 2) Choose OAuth client type

From the menu, select OAuth client ID.

<img width="997" height="384" alt="image" src="https://github.com/user-attachments/assets/75e0f4c5-96d0-488a-bc35-4074d9fa024a" />

### 3) Configure the OAuth client

Choose Desktop app.

<img width="1912" height="640" alt="image" src="https://github.com/user-attachments/assets/13f239f2-77e5-42f3-a30b-3e4577949aa6" />

Give it a descriptive name of your choice and click Create.

### 4) Download client secrets

After creation, download the client secrets JSON file and save it into your google-workspace-enum folder.

Name it something easy to reference (e.g., client_secrets.json).

<img width="1813" height="906" alt="image" src="https://github.com/user-attachments/assets/b3ff72f7-84b3-4145-937b-06d573ee377e" />

### 5) Add test users

Go to the Audience page and click on Add user.

Enter the email address of the Google Workspace user you want to test.

<img width="1915" height="712" alt="image" src="https://github.com/user-attachments/assets/a6d20ee9-7df5-4f72-b40d-92536c386c4a" />

### 6) Run gws-enum to start enumeration

    python3 gws_enum.py
