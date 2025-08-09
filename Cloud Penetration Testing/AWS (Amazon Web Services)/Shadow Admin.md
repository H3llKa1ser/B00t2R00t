# AWS Shadow Admin

# TLDR: Fix later

## Admin equivalent permission

### 1) AdministratorAccess

 - "Action": "*"

 - "Resource": "*"

### 2) ec2:AssociateIamInstanceProfile : attach an IAM instance profile to an EC2 instance

    aws ec2 associate-iam-instance-profile --iam-instance-profile Name=admin-role

### 3) iam:CreateAccessKey : create a new access key to another IAM admin account

    aws iam create-access-key –user-name TARGET_USER

### 4) iam:CreateLoginProfile : add a new password-based login profile, set a new password for an entity and impersonate it

    aws iam create-login-profile –user-name TARGET_USER –password 'PASSWORD'

### 5) iam:UpdateLoginProfile : reset other IAM users’ login passwords.

    aws iam update-login-profile –user-name TARGET_USER –password 'PASSWORD'

### 6) iam:AttachUserPolicy, iam:AttachGroupPolicy or iam:AttachRolePolicy : attach existing admin policy to any other entity he currently possesses

    aws iam attach-user-policy –user-name MY_USERNAME –policy-arn arn:aws:iam::aws:

## OR

    aws iam attach-user-policy –user-name MY_USERNAME –policy-arn arn:aws:iam::aws:

## OR

    aws iam attach-role-policy –role-name ROLE_I_CAN_ASSUME –policy-arn arn:aws:iam::

### 7) iam:PutUserPolicy, iam:PutGroupPolicy or iam:PutRolePolicy : added inline policy will allow the attacker to grant additional privileges to previously compromised entities.

    aws iam put-user-policy –user-name MY_USERNAME –policy-name MY_INLINE_POLICY

### 8) iam:CreatePolicy : add a stealthy admin policy

### 9) iam:AddUserToGroup : add into the admin group of the organization.

    aws iam add-user-to-group –group-name TARGET_GROUP –user-name MY_USERNAME

### 10) iam:UpdateAssumeRolePolicy + sts:AssumeRole : change the assuming permissions of a privileged role and then assume it with a non-privileged account.

    aws iam update-assume-role-policy –role-name ROLE_I_CAN_ASSUME –policy-document file://

### 11) iam:CreatePolicyVersion & iam:SetDefaultPolicyVersion : change customer-managed policies and change a non-privileged entity to be a privileged one.

    aws iam create-policy-version –policy-arn target_policy_arn –policy-document file://

    aws iam set-default-policy-version –policy-arn target_policy_arn –version-id v2

### 12) lambda:UpdateFunctionCode : give an attacker access to the privileges associated with the Lambda service role that is attached to that function.

    aws lambda update-function-code –function-name target_function –zip-file fileb://

### 13) glue:UpdateDevEndpoint : give an attacker access to the privileges associated with the role attached to the specific Glue development endpoint.

    aws glue –endpoint-name target_endpoint –public-key file://path/to/my/public/ssh/id_rsa.pub

### 14) iam:PassRole + ec2:CreateInstanceProfile/ec2:AddRoleToInstanceProfile : an attacker could create a new privileged instance profile and attach it to a compromised EC2 instance that he possesses.

### 15) iam:PassRole + ec2:RunInstance : give an attacker access to the set of permissions that the instance profile/role has, which again could range from no privilege escalation to full administrator access of the AWS account

    aws ec2 run-instances –image-id ami-a4dc46db –instance-type t2.micro –iam-instance-

    aws ec2 run-instances –image-id ami-a4dc46db –instance-type t2.micro –iam-instance-

### 16) iam:PassRole + lambda:CreateFunction + lambda:InvokeFunction : give a user access to the privileges associated with any Lambda service role that exists in the account.

    aws lambda create-function –function-name my_function –runtime python3.6 –role

    aws lambda invoke –function-name my_function output.txt

### 17) iam:PassRole + glue:CreateDevEndpoint : access to the privileges associated with any Glue service role that exists in the account.

    aws glue create-dev-endpoint –endpoint-name my_dev_endpoint –role-arn arn_of_glue_
