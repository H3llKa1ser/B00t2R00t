# AWS IAM Enumeration

### Configure AWS cli

 - aws configure

### OR configure it using a profile

 - aws configrue --profile EXAMPLE_NAME

### The credential file is located in ~/.aws/credentials

## Commands:

# 1) Listing IAM access keys

 - aws iam list-access-keys (Listing IAM access keys)

# 2) Enumerating IAM users

 - aws sts get-caller-identity (Checking credentials for the user)

 - aws iam list-users (Listing IAM users)

 - aws s3api put-bucket-policy --bucket iam-enum --policy file://s3_policy.json (Enumerate users and roles via S3 Bucket Policy)

 - aws iam list-groups-for-user --user-name USER_NAME (Listing the IAM groups that the specified IAM user belongs to)

 - aws iam list-attached-user-policies --user-name USER_NAME (Listing all manages policies that are attached to the specified IAM user)

 - aws iam list-user-policies --user-name USER_NAME (Listing the names of the inline policies embedded in the specified IAM user)

# 3) Enumerating IAM groups

 - aws iam list-groups (Listing IAM groups)

 - aws iam list-attached-group-policies --group-name GROUP_NAME (Listing all managed policies that are attached to the specified IAM Group)

 - aws iam list-group-policies --group-name GROUP_NAME (Listing the names of the inline policies embedded in the specified IAM Group)

# 4) Enumerating roles

 - aws iam list-roles (Listing IAM roles)

 - aws iam list-attached-role-policies --role-name ROLE_NAME (Listsing all managed policies that are attached to the specified IAM role)

 - aws iam list-role-policies --role-name ROLE_NAME (Listing the names of the inline policies embedded in the specified IAM role)

# 5) Enumerating Policies

 - aws iam list-policies (Listing of IAM policies)

 - aws iam get-policy --policy-arn POLICY_ARN (Retrieving information about the specified managed policy)

 - aws iam list-policy-versions --policy-arn POLICY_ARN (Listing information about the versions of the specified manages policy)

 - aws iam get-policy-version --policy-arn POLICY_ARN --version-id VERSION_ID (Retrieving information about the specific version of the specified managed policy)

### Retrieving the specified inline policy document that is embedded on the specified IAM user / group / role

 - aws iam get-user-policy --user-name USER_NAME --policy-name POLICY_NAME

 - aws iam get-group-policy --group-name GROUP_NAME --policy-name POLICY_NAME

 - aws iam get-role-policy --role-name ROLE_NAME --policy-name POLICY_NAME

