# Cobalt Strike Web Services

### Many Cobalt Strike features run from their own web server. These services include the system profiler, HTTP Beacon, and Cobalt Strike’s web drive-by attacks. It’s OK to host multiple Cobalt Strike features on one web server.

### To manage Cobalt Strike’s web services, go to View -> Web Drive-by -> Manage. Here, you may copy any Cobalt Strike URL to the clipboard or stop a Cobalt Strike web service

### Use View -> Web Log to monitor visits to your Cobalt Strike web services.

### If Cobalt Strike’s web server sees a request from the Lynx, Wget, or Curl browser; Cobalt Strike will automatically return a 404 page. Cobalt Strike does this as light protection against blue team snooping. The can be configured with the Malleable C2 ‘.http-config.block_useragents’ option.

