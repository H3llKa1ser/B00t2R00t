# C2 Advanced Options

### Advanced options, as the name suggests, are for advanced users that know what they're doing. Using these options isn't the best user experience and may result in broken or unexpected implant behavior. Only use these options if you understand what they do.

### Advanced options are configured per-C2 endpoint and are passed as URL encoded parameters to the C2 URL in the generate command. For example:

#### 1) generate --http http://example.com?driver=wininet

# HTTP C2 Advanced Options

#### 1) net-timeout 

- Network timeout value, parsed by time.ParseDuration.

#### 2) tls-timeout 

- TLS handshake timeout value, parsed by time.ParseDuration.

#### 3) poll-timeout 

- Poll timeout value, parsed by time.ParseDuration.

#### 4) max-errors 

- Max number of HTTP errors before failing (integer parsed by strconv.Atoi).

#### 5) driver 

- Manually specify the HTTP driver (string). On windows this value can be set to wininet to use the wininet HTTP library for C2 communication.

#### 6) force-http 

- Set to true to always force the use of plaintext HTTP.

#### 7) disable-accept-header 

- Set to true to disable the HTTP accept request header.

#### 8) disable-upgrade-header 

- Set to true to disable the HTTP upgrade request header.

#### 9) proxy 

- Manually specify HTTP proxy, this value is only used with Go HTTP driver, and the format should be one that is accepted by the Go HTTP library. You must specify a URI scheme with the hostname of the proxy. For example, ?proxy=http://myproxy.corp.com:8080

#### 10) proxy-username 

- Specify a proxy username. Only valid with the Go HTTP driver.

#### 11) proxy-password 

- Specify the proxy password. Only valid with the Go HTTP driver.

#### 12) ask-proxy-creds 

- Set to true to ask the user for HTTP proxy credentials. Only valid when used with the wininet HTTP driver.

#### 13) host-header 

- Used for domain fronting.

# DNS C2 Advanced Options

#### 1) timeout 

- Network timeout value, parsed by time.ParseDuration.

#### 2) retry-wait 

- Upon query failure, wait this amount of time before retrying.

#### 3) retry-count 

- Upon query failure, retry this many times before failing.

#### 4) workers-per-resolver 

- Number of worker goroutines per functional DNS resolver.

#### 5) max-errors 

- Max number of query errors before failing (integer parsed by strconv.Atoi).

#### 6) force-base32 

- Always use Base 32 encoding.

#### 7) force-resolv-conf 

- Force the use of a provided resolv.conf. Note that you'll need to URL encode the newlines/etc of the file contents into the parameter.

#### 8) resolvers 

- Force the use of specific DNS resolvers. You can supply more than one by separating them with +, i.e. ...?resolvers=1.1.1.1+9.9.9.9

