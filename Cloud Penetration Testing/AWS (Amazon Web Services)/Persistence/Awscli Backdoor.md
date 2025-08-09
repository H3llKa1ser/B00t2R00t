# Awscli Backdoor

### List access keys for a user

    aws iam list-access-keys --user-name USERNAME

### Backdoor account with second set of access keys

    aws iam create-access-key --user-name USERNAME
