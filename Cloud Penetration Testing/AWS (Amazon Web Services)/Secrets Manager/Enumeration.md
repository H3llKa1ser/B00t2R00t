# AWS Secrets Manager Enumeration

## Commands:

 - aws secretsmanager list-secrets (Listing all secrets stored by Secrets Manager)

 - aws secretsmanager describe-secret --secret-id NAME (Listing information about a specific secret)

 - aws secretsmanager get-resource-policy --secret-id ID (Getting policies attached to the specified secret)

 - aws kms list-keys (Listing keys in Key Management Service (KMS))

 - aws kms describe-key --key-id ID (Listing information about a specific key)

 - aws kms list-key-policies --key-id ID (Listing policies attached to a specific key)

 - aws kms get-key-policy --policy-name name --key-id ID (Getting full information about a policy. Shows who can access the keys)
