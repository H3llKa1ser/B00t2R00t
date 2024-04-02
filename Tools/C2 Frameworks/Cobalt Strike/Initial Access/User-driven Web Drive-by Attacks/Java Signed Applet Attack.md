# Java Signed Applet Attack

### This attack starts a web server hosting a self-signed Java applet. Visitors are asked to give the applet permission to run. When a visitor grants this permission, you gain access to their system.

### The Java Signed Applet Attack uses Cobalt Strike’s Java injector. On Windows, the Java injector will inject shellcode for a Windows listener directly into memory for you

### Navigate to Attacks -> Signed Applet Attack.

## Parameters

### 1) Local URL/Host/Path

 - Set the Local URL Path, Host and Port to configure the
webserver.

### 2) Listener

 - - Press the ... button to select a Cobalt Strike listener you would like to output
a payload for.

### 3) SSL

 - Check to serve this content over SSL. This option is available when you specify a
valid SSL certificate in your Malleable C2 profile.

### Press Launch to start the attack.
