# Pacu AWS Exploitation Framework

## Github repo: https://github.com/RhinoSecurityLabs/pacu

### Import AWS keys for a specific profile

    import_keys PROFILE_NAME

    set_keys (Insert valid Access Key and Secret Access Key to gain a session)

### Detect if keys are honey token keys

    run iam__detect_honeytokens

### Enumerate account information and permissions

    run iam__enum_users_roles_policies_groups

    run iam__enum_permissions

    run iam__enum_users --role-name ROLE_NAME --account-id AWS_ACCOUNT_ID (Enumerate IAM Users)

    run iam__enum_roles --role-name ROLE_NAME --account-id AWS_ACCOUNT_ID (Enumerate IAM Roles and possibly assume a role we may find)

    run iam__bruteforce_permissions (Bruteforce IAM permissions)

    whoami

### Check for privilege escalation

    run iam__privesc_scan
