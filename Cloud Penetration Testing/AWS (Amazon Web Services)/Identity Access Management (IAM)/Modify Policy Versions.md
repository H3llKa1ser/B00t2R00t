# Modify Policy Versions

## Prerequisites:

Compromised account that has the permissions:

    iam:SetDefaultPolicyVersion

An attacker can look through the history of a policy. If a previous version was overly permissive (perhaps an old admin policy that was later restricted), the attacker can switch the active version back to the insecure one.

### 1) Command

    aws iam set-default-policy-version --policy-arn arn:aws:iam::123456789012:policy/MyPolicy --version-id v2
