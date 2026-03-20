# STS Credentials Basics

### 1) Create a user (CloudShell)

Save output to use on our attack machine

    aws iam create-user --user-name USERNAME

### 2) Add them to a group, granting them some permissions if the group has any

    aws iam add-user-to-group --user-name USERNAME --group-name GROUPNAME

### 3) Verify

    aws iam list-groups-for-user --user-name USERNAME

### 4) Create an access key for our user

    aws iam create-access-key --user-name USERNAME

### 5) Add the keys as environment variables (Attack machine)

    export AWS_SECRET_ACCESS_KEY=40_CHAR_ACCESS_KEY
    export AWS_ACCESS_KEY_ID=AKIA_ACCESS_KEY_ID

### 6) Set these environment variables in AWS CLI

    aws configure

### 7) Validate

    aws sts get-caller-identity

### 8) Assume role you want 

Take the output and set the as AWS CLI environment variables

    aws sts assume-role --role-arn arn:aws:iam::ACCOUNT_ID:role/ROLENAME --role-session-name SESSIONNAME

### 9) Set output

    export AWS_SECRET_ACCESS_KEY=40_CHAR_ACCESS_KEY
    export AWS_ACCESS_KEY_ID=ASIA_TEMP_ACCESS_KEY_ID
    export AWS_SESSION_TOKEN=BIG_ASS_SESSION_TOKEN_PRINTED_FROM_PREVIOUS_COMMAND

### 10) Validate

    aws sts get-caller-identity
