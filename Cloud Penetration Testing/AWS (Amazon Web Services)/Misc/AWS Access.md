# AWS Access

## AWS Console (GUI)

### 1) Grant a user access to the AWS Console

    aws iam create-login-profile --user USERNAME --password 'PASSWORD123'

### 2) Change the user's password

    aws iam update-login-profile --user USER --password 'PASSWORD321'

### 3) Check for password policy

    aws iam get-account-password-policy

## Access Keys

### 1) Create Access Key

     aws iam create-access-key --user-name USERNAME

### 2) Request Short-term keys (STS)

    aws sts get-session-token

### 3) Get information about an Access Key

    aws sts get-access-key-info --access-key-id AKIAEXAMPLE

### 4) Disable AWS Access Key

    aws iam update-access-key --access-key-id AKIA... --status Inactive

### 5) Reenable Access Key

    aws iam update-access-key --access-key-id AKIA... --status Active

### 6) Delete AWS Access Key

    aws iam delete-access-key --access-key-id AKIA...
