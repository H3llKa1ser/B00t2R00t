# PassRole and EC2

## Prerequisites:

A compromised account with permissions:

    iam:PassRole
    ec2:RunInstances

## Attack summary

With these permissions, an attacker can launch a new EC2 instance, attach a high-privilege IAM role to it, access that instance and steal the role's temporary credentials (IMDS query).

## Example

    curl http://169.254.169.254/latest/meta-data/iam/security-credentials/CloudAdminRole
