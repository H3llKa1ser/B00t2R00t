# Valid Credentials

### 1) Set the access key, access key ID and region name

    aws configure

### 2) Verify identity (like whoami)

    aws sts get-caller-identity

## IAM

### 1) Enumerate current user

    aws iam get-user

### 2) Enumerate groups for a specific user

    aws iam list-groups-for-user --user-name USERNAME

### 3) List attached user policies

    aws iam list-attached-user-policies --user-name USERNAME

### 4) List inline policies

    aws iam list-user-policies --user-name USERNAME

### 5) Enumerate policy versions of a specific policy

    aws iam list-policy-versions --policy-arn arn:aws:iam::aws:policy/POLICY_NAME

### 6) See more detailed for a specific version of a policy

    aws iam get-policy-version --policy-arn arn:aws:iam::aws:policy/POLICY_NAME --version-id vNUM

