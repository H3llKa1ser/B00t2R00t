# Client-side System Profiler

### The system profiler is a reconnaissance tool for client-side attacks. This tool starts a local webserver and fingerprints any one who visits it. The system profiler provides a list of applications and plugins it discovers through the user’s browser. The system profiler also attempts to discover the internal IP address of users who are behind a proxy server.

### To start the system profiler, go to Attacks -> System Profiler. To start the profiler you must specify a URI to bind to and a port to start the Cobalt Strike web- server from.

### If you specify a Redirect URL, Cobalt Strike will redirect visitors to this URL once their profile is taken. Click Launch to start the system profiler.

### The System Profiler uses an unsigned Java Applet to decloak the target’s internal IP address and determine which version of Java the target has. With Java’s click-to-run security feature— this could raise suspicion. Uncheck the Use Java Applet to get information box to remove the Java Applet from the System Profiler.

### Check the Enable SSL box to serve the System Profiler over SSL. This box is disabled unless you specify a valid SSL certificate with Malleable C2. 

