# Resource: https://wiki.zacheller.dev/pentest/privilege-escalation/spawning-a-tty-shell

## python -c 'import pty; pty.spawn("/bin/sh")'

## echo os.system('/bin/bash')

## /bin/sh -i

## perl —e 'exec "/bin/sh";'

## perl: exec "/bin/sh";

## ruby: exec "/bin/sh"

## lua: os.execute('/bin/sh')

## (From within IRB)
## exec "/bin/sh"

## (From within vi)
## :!bash

## (From within vi)
## :set shell=/bin/bash:shell

## (From within nmap)
## !sh

# From netsec.ws
