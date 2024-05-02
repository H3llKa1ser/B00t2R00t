# Code-related Vulnerabilities

### The "cloudification" of existing applications and the drive toward cloud-native development are some of the driving forces bringing organizations into the Azure cloud. By porting existing or legacy applications into a cloud environment, many organizations are just bringing along many of the old vulnerabilities that previously existed in their original applications.

### While there are many benefits to moving to the cloud, it is not a magic bullet to fix application vulnerabilities. Some of the existing common application issues can actually become more impactful in a cloud environment, as the platform can then be abused by these issues to escalate access.

# 1) SQL Injection

 - By injecting SQL queries into an application, an attacker may be able to access sensitive information in the database, force the database to authenticate to the attacker, or even achieve command execution on the database server. In an Azure context, an attacker could potentially execute commands on a SQL database virtual machine, which could then be used to pivot to the internal virtual networks.

# 2) LFI and Directory Traversal

 - By accessing local files from the web server, an attacker may be able to access configuration files on the hosts. With applications in Azure, many of these configuration files contain access keys for Azure services, such as Storage accounts, so there may be opportunities to pivot from these services.

# 3) Command Injection

 - There are many ways for commands to make their way into an application server, but in a cloud environment, these can be abused to access additional resources in the subscription. Additionally, if the application server is utilizing a managed identity, the attacker may be able to execute commands that can generate an authorization token for the managed identity. This token could then be used to assume the identity of the managed identity.

# 4) SSRF

 - SSRF is an application issue that allows an attacker to force the application server to make outbound requests. This issue has seen some very impactful usage in AWS environments, where it can be used to query the EC2 metadata service to return IAM credentials. Due to the way the Azure metadata service operates, there is a header that is required for making similar requests in Azure. Metadata service credential attacks can be executed via command injection in Azure, but not via SSRF attacks.
