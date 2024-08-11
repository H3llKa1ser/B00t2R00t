# IAM Policy Enumeration

### Steps:

 - 1) gcloud projects get-iam-policy PROJECT_ID > policy.yml (List IAM policy per project, then save it locally as a YAML file)

 - 2) Run a python script to convert .yml to .json file (Script is in the scripts directory in this repo)

 - 3) python3 main.py /path/to/policy.json (Run the script to visualize the .json file into a graph in .png format) Script: https://raw.githubusercontent.com/hac01/iam-policy-visualize/main/main.py
  
 - 4) open iam_policy_graph.png (Happy graphing)
