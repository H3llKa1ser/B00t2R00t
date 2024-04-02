# Java Smart Applet Attack

### Cobalt Strike’s Smart Applet Attack combines several exploits to disable the Java security sandbox into one package. This attack starts a web server hosting a Java applet. Initially, this applet runs in Java’s security sandbox and it does not require user approval to start.

### The applet analyzes its environment and decides which Java exploit to use. If the Java version is vulnerable, the applet will disable the security sandbox, and execute a payload using Cobalt Strike’s Java injector.

### Navigate to Attacks -> Smart Applet Attack.

## Parameters

### 1) Local URL/Host/Path

 - Set the Local URL Path, Host and Port to configure the
webserver.

### 2) Listener

 - Press the ... button to select a Cobalt Strike listener you would like to output
a payload for.

### 3) SSL

 - Check to serve this content over SSL. This option is available when you specify a
valid SSL certificate in your Malleable C2 profile.

### Press Launch to start the attack.
