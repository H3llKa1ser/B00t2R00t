# AWS IAM Interesting permissions

 - iam:AttachUserPolicy -> Attach a policy to a user

 - aws iam put-user-policy --user-name example_username --policy-name example_name --

 - iam:AttachGroupPolicy -> Attach a policy to a group

 - iam:AttachRolePolicy -> Attach a policy to a role

 - iam:CreateAccessKey -> Creates a new access key

 - iam:CreateLoginProfile -> Creates a new login profile

 - iam:UpdateLoginProfile -> Update an existing login profile

 - iam:PassRole and ec2:RunInstances -> Creates an EC2 instance with an existing instance profile

 - iam:PuserUserPolicy -> Create/Update an inline policy

 - iam:PutGroupPolicy -> Create/Update an inline policy for a group

 - iam:PutRolePolicy -> Create/Update an inline policy for a role

 - iam:AddUserToGroup -> Add an user to a group

 - iam:UpdateAssumeRolePolicy and sts:AssumeRole -> Update the AssumeRolePolicyDocument of a role

 - iam:PassRole,lambda:CreateFunction and lambda:InvokeFunction -> Pass a role to a new lambda function and invoke it

 - lambda:UpdateFunctionCode -> Update the code of an existing lambda function

