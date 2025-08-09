# IAM Policy Enumeration

## Custom Roles information: https://gcp.permissions.cloud/predefinedroles

### Steps:

#### 1) List IAM policy per project, then save it locally as a YAML file

    gcloud projects get-iam-policy PROJECT_ID > policy.yml 

#### 2) Run a python script to convert .yml to .json file (Script is in the scripts directory in this repo)

#### 3) Run the script to visualize the .json file into a graph in .png format Script: https://raw.githubusercontent.com/hac01/iam-policy-visualize/main/main.py

    python3 main.py /path/to/policy.json 
  
#### 4) Happy graphing

    open iam_policy_graph.png 

## Alternate Method: gcloud CLI

#### 1) Return the roles bound to our current user

    gcloud projects get-iam-policy PROJECT --flatten="bindings[].members" --format='table(bindings.role, bindings.members)' --filter="bindings.members:USER@PROJECT.iam.gserviceaccount.com" 

#### 2) Enumerate Permissions based on the specific role bound to our current user

    gcloud iam roles describe ROLE_NAME --project=PROJECT_ID 
