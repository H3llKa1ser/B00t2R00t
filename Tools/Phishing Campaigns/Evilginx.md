# Evilginx Man-in-the-Middle attack framework

### Github repo: https://github.com/kgretzky/evilginx2

### Resources: https://breakdev.org/evilginx-3-3-go-phish/

## Setup:

### Our Evilginx server needs to be accessible over the internet and for this we can stand up a VM from any cloud provider. If the target uses Azure (for example) then this cloud platform address space is likely to be allowlisted, so it would make sense to stand up an Azure virtual machine in that case. We used a Ubuntu Linux EC2 instance.

 - ./evilginx (Run evilginx)

 - build/evilginx -p phishlets (Specify a path to a directory containing our Evilginx phishlets)

 - 
