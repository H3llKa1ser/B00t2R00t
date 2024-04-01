# HTTP Proxy Configuration

### The (Manual) Proxy Settings dialog offers several options to control the proxy configuration for Beacon’s HTTP and HTTPS requests. The default behavior of Beacon is to use the Internet Explorer proxy configuration for the current process/user context.

### The Type field configures the type of proxy. The Host and Port fields tell Beacon where the proxy lives. The Username and Password fields are optional. These fields specify the credentials Beacon uses to authenticate to the proxy.

### Check the Ignore proxy settings; use direct connection box to force Beacon to attempt its HTTP and HTTPS requests without going through a proxy.

### Press Set to update the Beacon dialog with the desired proxy settings. Press Reset to set the proxy configuration back to the default behavior.

## Note: The manual proxy configuration affects the HTTP and HTTPS Beacon payload stages only. It does not propagate to the payload stagers.
