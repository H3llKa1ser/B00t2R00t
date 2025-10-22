# Portfwd

Access port 3389 of the host 10.10.100.30 through our local ip:33890

    portfwd add -b 127.0.0.1:33890 -r 10.10.100.30:3389
