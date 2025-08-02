#### 1) 

    python -c 'import pty;pty.spawn("/bin/bash")'

#### 2) 

    export TERM=xterm

#### 3) Background to our own terminal 

    CTRL + Z 

#### 4) Get back to our shell

    stty raw -echo;fg

#### 5) 

    stty rows 35 cols 136

