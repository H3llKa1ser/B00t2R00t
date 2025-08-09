# AWS IAM Interesting permissions

| Service          | IAM/Service Action(s)                                                               | Description                                                                                     |
| ---------------- | ------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------- |
| **IAM**          | `iam:AttachUserPolicy`                                                               | Attach a policy to a user                                                                       |
|                  | `aws iam put-user-policy`<br>`--user-name example_username`<br>`--policy-name example_name --` | AWS CLI example to attach an inline policy to a user                                            |
|                  | `iam:AttachGroupPolicy`                                                              | Attach a policy to a group                                                                      |
|                  | `iam:AttachRolePolicy`                                                               | Attach a policy to a role                                                                       |
|                  | `iam:CreateAccessKey`                                                                | Creates a new access key                                                                        |
|                  | `iam:CreateLoginProfile`                                                             | Creates a new login profile                                                                     |
|                  | `iam:UpdateLoginProfile`                                                             | Update an existing login profile                                                                |
|                  | `iam:PutUserPolicy`                                                                  | Create/Update an inline policy for a user                                                       |
|                  | `iam:PutGroupPolicy`                                                                 | Create/Update an inline policy for a group                                                      |
|                  | `iam:PutRolePolicy`                                                                  | Create/Update an inline policy for a role                                                       |
|                  | `iam:AddUserToGroup`                                                                 | Add a user to a group                                                                           |
|                  | `iam:UpdateAssumeRolePolicy`<br>`sts:AssumeRole`                                     | Update the AssumeRolePolicyDocument of a role and assume it                                     |
| **IAM + EC2**    | `iam:PassRole`<br>`ec2:RunInstances`                                                  | Create an EC2 instance with an existing instance profile                                        |
| **IAM + Lambda** | `iam:PassRole`<br>`lambda:CreateFunction`<br>`lambda:InvokeFunction`                  | Pass a role to a new Lambda function and invoke it                                              |
| **Lambda**       | `lambda:UpdateFunctionCode`                                                           | Update the code of an existing Lambda function                                                  |
