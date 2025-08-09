# AWS Secrets Manager Enumeration

## Commands:

#### 1) Listing all secrets stored by Secrets Manager

    aws secretsmanager list-secrets 

#### 2) Listing information about a specific secret

    aws secretsmanager describe-secret --secret-id NAME 

#### 3) Getting policies attached to the specified secret

    aws secretsmanager get-resource-policy --secret-id ID 

#### 4) Listing keys in Key Management Service (KMS)

    aws kms list-keys 

#### 5) Listing information about a specific key

    aws kms describe-key --key-id ID 

#### 6) Listing policies attached to a specific key

    aws kms list-key-policies --key-id ID 

#### 7) Getting full information about a policy. Shows who can access the keys

    aws kms get-key-policy --policy-name name --key-id ID 
