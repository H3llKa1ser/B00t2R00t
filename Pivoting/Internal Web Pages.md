# Internal Web Pages Access

### After we set our proxy, we can access internal resources from our browsers:

#### 1) Google Chrome

     google-chrome --proxy-server="socks5://127.0.0.1:1080"

#### 2) Firefox

1) Go to Settings → Network Settings → Manual Proxy Configuration.

2) Set:

        SOCKS Host: 127.0.0.1
        Port: 1080

3) Check SOCKS v5.

4) Enable Proxy DNS when using SOCKS v5 (to avoid DNS leaks).

5) Save and try accessing the internal web pages.


## TIP: We may also use FoxyProxy extension if configured properly

## TIP 2: Use SSH Dynamic proxy and usage of Chisel IS NOT RECOMMENDED due to very slow speeds while browsing using the socks proxy
