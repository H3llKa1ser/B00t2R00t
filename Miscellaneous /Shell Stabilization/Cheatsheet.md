# Resource: https://wiki.zacheller.dev/pentest/privilege-escalation/spawning-a-tty-shell

## Python 1

    python -c 'import pty; pty.spawn("/bin/sh")'

## Python 2

    echo os.system('/bin/bash')

## Sh Interactive

    /bin/sh -i

## Perl 1

    perl —e 'exec "/bin/sh";'

## Perl 2

    perl: exec "/bin/sh";

## Ruby

    ruby: exec "/bin/sh"

## Lua

    lua: os.execute('/bin/sh')

## (From within IRB)

    exec "/bin/sh"

## (From within vi)

    :!bash

## (From within vi)

    :set shell=/bin/bash:shell

## (From within nmap)

    !sh

# From netsec.ws
