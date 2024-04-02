# Scripted Web Delivery (S)

### This feature generates a stageless Beacon payload artifact, hosts it on Cobalt Strike’s web server, and presents a one-liner to download and run the artifact.

### Navigate to Attacks -> Scripted Web Delivery (S) from the menu.

## Parameters

### 1) Local URL/Host/Path

 - Set the Local URL Path, Host and Port to configure the
webserver. Make sure the Host field matches the CN field of your SSL certificate.
This will avoid a situation where this feature fails because of a mismatch
between these fields.

### 2) Listener

 - Press the ... button to select a Cobalt Strike listener you would like to output
a payload for.

### 3) Type

 - Use the drop-down menu to select one of the following types:

 - 1) bitsadmin: This option hosts an executable and uses bitsadmin to download it.
The bitsadmin method runs the executable via cmd.exe.

 - 2) exe: This option generates an executable and hosts it on Cobalt Strike’s web
server.

 - 3) powershell: This option hosts a PowerShell script and uses powershell.exe to
download the script and evaluate it.

 - 4) powershell IEX: This option hosts a PowerShell script and uses powershell.exe
to download the script and evaluate it. Similar to prior powershell option, but
it provides a shorter Invoke-Execution one-liner command.

 - 5) python: This option hosts a Python script and uses python.exe to download the
script and run it. Each of these options is a different way to run a Cobalt Strike
listener.

### 4) x64

 - Check the box to generate an x64 stager for the selected listener.

### 5) SSL

 - Check to serve this content over SSL. This option is available when you specify a
valid SSL certificate in your Malleable C2 profile.

### Press Launch to start the attack.
