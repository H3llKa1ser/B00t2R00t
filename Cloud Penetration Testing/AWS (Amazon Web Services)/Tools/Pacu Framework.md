# Pacu AWS Exploitation Framework

## Github repo: https://github.com/RhinoSecurityLabs/pacu

### Import AWS keys for a specific profile

 - import_keys PROFILE_NAME

### Detect if keys are honey token keys

 - run iam__detect_honeytokens

### Enumerate account information and permissions

 - run iam__enum_users_roles_policies_groups

 - run iam__enum_permissions

 - whoami

### Check for privilege escalation

 - run iam__privesc_scan
