## If there is no python on the host machine, try these one liners:

    SHELL=/bin/bash script -q /dev/null

    script /dev/null -c bash

    /usr/bin/script -qc /bin/bash /dev/null
