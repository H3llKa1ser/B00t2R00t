# Client-side System Profiler

### The system profiler is a reconnaissance tool for client-side attacks. This tool starts a local webserver and fingerprints any one who visits it. The system profiler provides a list of applications and plugins it discovers through the user’s browser. The system profiler also attempts to discover the internal IP address of users who are behind a proxy server.

### To start the system profiler, go to Attacks -> System Profiler. To start the profiler you must specify a URI to bind to and a port to start the Cobalt Strike web- server from.

### If you specify a Redirect URL, Cobalt Strike will redirect visitors to this URL once their profile is taken. Click Launch to start the system profiler.

### The System Profiler uses an unsigned Java Applet to decloak the target’s internal IP address and determine which version of Java the target has. With Java’s click-to-run security feature— this could raise suspicion. Uncheck the Use Java Applet to get information box to remove the Java Applet from the System Profiler.

### Check the Enable SSL box to serve the System Profiler over SSL. This box is disabled unless you specify a valid SSL certificate with Malleable C2. 

# Application Browser

### To view the results from the system profiler, go to View -> Applications. This opens an Applications tab with a table showing all application information captured by the System Profiler.

## Analyst Tips

### The Application Browser has a lot of information useful to plan a targeted attack. Here's how to get the most out of this output:

#### The internal IP address field is gathered from a benign unsigned Java applet. If this field says unknown, this means the Java applet probably did not run. If you see an IP address here, this means the unsigned Java applet ran.

#### Internet Explorer will report the base version the user installed. As Internet Explorer gets updates--the reported version information does not change. Cobalt Strike uses the JScript.dll version to estimate Internet Explorer's patch level. Go to support.microsoft.com and search for JScript.dll's build number (the third number in the version string) to map it to an Internet Explorer update.

#### A *64 next to an application means it's an x64 application.

