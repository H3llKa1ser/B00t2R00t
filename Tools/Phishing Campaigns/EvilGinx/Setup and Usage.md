# Evilginx Man-in-the-Middle attack framework

### Github repo: https://github.com/kgretzky/evilginx2

### Resources: https://breakdev.org/evilginx-3-3-go-phish/

## Setup:

### Our Evilginx server needs to be accessible over the internet and for this we can stand up a VM from any cloud provider. If the target uses Azure (for example) then this cloud platform address space is likely to be allowlisted, so it would make sense to stand up an Azure virtual machine in that case. We used a Ubuntu Linux EC2 instance.

 - ./evilginx (Run evilginx)

### After running our built evilginx binary we confirm it's working see that we need to specify the path to a directory containing our Evilginx phishlets. Phishlets are small YAML configuration files that configure Evilginx to target specific websites for phishing attacks. The example phishlet exists in the phishlets directory by default.

 - build/evilginx -p phishlets (Specify a path to a directory containing our Evilginx phishlets)

### Next, we need to configure the domain to use for our phishing campaign. You can register a domain if needed. We have used the domain LEGITIMATE_DOMAIN that looks legitimate (example). We also provide Evilginx with the public IP address of the VM or any redirector you have configured. 

 - config ipv4 external EXTERNAL_IP

 - config domain LEGITIMATE_DOMAIN.COM
