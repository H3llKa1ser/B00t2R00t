# Patching-related Vulnerabilities

### While these issues are less commonly found, there are still plenty of new security patches released every week. As a result, there are plenty of forgotten or abandoned services, applications, and virtual machines that miss these patches

### From an external perspective, we will typically be scanning Azure virtual machines, with public IPs, for internet-facing services. These services can typically be fingerprinted by network scanning tools to identify the specific version of the software hosting the service.

### Once the version of the software has been identified, we can either use vulnerability scanners (Nessus, Nexpose, and so on) or some basic Google skills to find potential vulnerabilities in these services.

